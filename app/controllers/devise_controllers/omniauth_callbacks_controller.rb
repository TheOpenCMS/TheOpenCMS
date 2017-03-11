class DeviseControllers::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  %w[ vkontakte facebook twitter google_oauth2 odnoklassniki ].each do |network_name|
    define_method network_name do
      auth
    end
  end

  def failure
    action_after_failure_oauth_sign_up
  end

  def delete_provider
    if credential = current_user.credentials.where(provider: params[:provider]).first
      credential.destroy
    end

    redirect_to :back
  end

  private

  def auth
    @omniauth      = request.env['omniauth.auth']
    uid, provider  = @omniauth['uid'], @omniauth['provider']
    @credential    = Credential.find_by_uid_and_provider(uid, provider)

    @callback_path    = params[:callback_path]    # where to redirect after oauth success
    @callback_process = params[:callback_process] # [for future] callback process name after oauth success

    return credential_was_found if @credential

    if current_user
      current_user.send(:oauth_set_social_network_url, @omniauth)
      current_user.save

      current_user.add_credential(@omniauth)
      action_after_add_credential
    else
      @oauth_user = User.new(oauth_data: @omniauth)
      @oauth_user.skip_confirmation!

      if @oauth_user.save
        action_after_sucesssful_oauth_sign_up
      else
        action_after_failure_oauth_sign_up
      end
    end
  end

  # OAUTH ACTIONS CALLBACKS

  def action_after_add_credential
    render views_path('close_popup_and_redirect_to_previous_page'), layout: false
  end

  def credential_was_found
    @oauth_user = @credential.user

    sign_in @oauth_user
    current_user.remember_me!

    render views_path('close_popup_and_redirect_to_cabinet'), layout: false
  end

  def action_after_sucesssful_oauth_sign_up
    @oauth_user.oauth_create_credential!
    @oauth_user.reset_oauth_data!

    sign_in @oauth_user
    current_user.remember_me!

    UserRoomLogger.new_user_created(@oauth_user.id)

    render views_path('close_popup_and_redirect_to_cabinet'), layout: false
  end

  def action_after_failure_oauth_sign_up
    render views_path('oauth_failure'), layout: 'user_room/layouts/base'
  end

  def views_path view_path
    "devise/omniauth_callbacks/#{ view_path }"
  end

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end
