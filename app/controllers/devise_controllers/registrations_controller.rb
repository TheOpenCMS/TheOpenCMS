class DeviseControllers::RegistrationsController < Devise::RegistrationsController
  layout 'user_room'

  before_filter :configure_sign_up_params, only: [:create]

  def create_email_registration_request
    _email       = params[:email].to_s.strip
    callback_path = params[:callback_path]

    user       = User.where(email: _email).first
    reg_req    = EmailRegistrationRequest.where("email = ? AND created_at > ?", _email, 1.hour.ago).first
    used_email = user.present? || reg_req.present?

    if used_email || _email.blank? || !_email.match(/@/)
      redirect_to :back, alert: 'Данный email невозможно использовать для запроса на регистрацию. Возможно он не корректен или уже использован.'
    else
      reg_req = EmailRegistrationRequest.create(email: params[:email])
      DeviseMailer.mail_registration_request(reg_req.id, callback_path).deliver
      redirect_to :back, notice: 'Запрос на регистрацию создан. Проверьте ваш почтовый ящик'
    end
  end

  def activate_email_registration_request
    uid = params[:uid].to_s.downcase
    callback_path = params[:callback_path]

    reg_req = EmailRegistrationRequest.where(uid: uid).first

    unless reg_req
      return redirect_to root_path, alert: 'Запрос на регистрацию не обнаружен'
    end

    used_email = User.where(email: reg_req.email).first

    if used_email
      return redirect_to root_path, alert: 'Запрос уже активирован'
    end

    pass = Digest::MD5.hexdigest("#{ Time.now }-#{ rand }")[0...8]
    user = User.new(email: reg_req.email, password: pass)

    user.skip_confirmation!
    user.save!
    sign_in user

    UserRoomLogger.new_user_created(user.id)

    next_page = callback_path.present? ? callback_path : cabinet_path
    redirect_to next_page, notice: 'Поздравляем! Вы зарегистрированы на сайте'
  end

  # def create
  #   build_resource(sign_up_params)

  #   resource_saved = resource.save
  #   yield resource if block_given?

  #   if resource_saved
  #     resource.reload

  #     if resource.active_for_authentication?
  #       set_flash_message :notice, :signed_up if is_flashing_format?
  #       sign_up(resource_name, resource)

  #       if request.format.json?
  #         return render 'devise/registrations/created', layout: false, status: 200
  #       else
  #         respond_with resource, location: after_sign_up_path_for(resource)
  #       end
  #     else
  #       set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
  #       expire_data_after_sign_in!

  #       if request.format.json?
  #         return render 'devise/registrations/account_should_be_activate', layout: false, status: 200
  #       else
  #         respond_with resource, location: after_inactive_sign_up_path_for(resource)
  #       end
  #     end
  #   else
  #     if request.format.json?
  #       return render 'devise/registrations/validation_errors', layout: false, status: 422
  #     else
  #       clean_up_passwords resource
  #       respond_with resource
  #     end
  #   end
  # end





  # before_filter :configure_account_update_params, only: [:update]
  #
  # GET /resource/sign_up
  # def new
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.

  # def configure_sign_up_params
  #   devise_parameter_sanitizer.for(:sign_up) << [:oauth_data]
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.for(:account_update) << :attribute
  # end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    cabinet_path
  end

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(resource)
    root_path
  end
end
