# include ::UserRoom::UsersController
module UserRoom
  module UsersController
    extend ActiveSupport::Concern

    included do
      layout -> { layout_template }
      include ::UserRoom::UserAvatarActions

      skip_before_action :authenticate_user!, only: %w[index show]
      skip_before_action :authorize_action!,  only: %w[index show edit update profile change_password change_email]
      skip_before_action :set_resource!,      only: %w[index profile]
      skip_before_action :authorize_owner!,   only: %w[index show profile]
      skip_before_action :authorize_admin!,   only: %w[index show edit update profile change_password change_email]
    end

    ##########################################
    ### Public actions
    ##########################################

    def index
      @users = ::User.max2min(:created_at).simple_sort(params).pagination(params)
      @users_count = ::User.count
    end

    def show; end

    ##########################################
    ### Restricted actions
    ##########################################

    def edit; end

    def update
      @user.assign_attributes(user_params)
      @user.content_processing!(current_user)

      if @user.save
        sign_in(@user, bypass: true) if user_params[:password].present?
        redirect_to edit_user_path(@user), notice: _t(:changes_saved)
      else
        @user.reload
        render 'users/edit'
      end
    end

    def profile
      @user = current_user
    end

    def change_password
      @user.send_reset_password_instructions
      redirect_to url_for([:edit, @user]), notice: _t(:password_instructions_sent)
    end

    def change_email
      if @user.update(user_params)
        redirect_to url_for([:edit, @user]), notice: _t(:email_instructions_sent)
      else
        @user.reload
        render 'users/edit'
      end
    end

    ##########################################
    ### Admin Actions
    ##########################################

    def autologin
      user = ::User.where(login: params[:id]).first
      sign_in(user, bypass: true)
      redirect_to profile_path
    end

    private

    def layout_template
      public_actions = %w[show index]
      return 'user_room_frontend' if public_actions.include?(action_name)
      'user_room_backend'
    end

    def set_resource!
      user_id = params[:id] || params[:user_id]
      @user = ::User.where(login: user_id).first
    end

    def user_params
      _params = params.require(:user).permit(
        :avatar, :raw_about,
        :login, :username, :email,
        :password, :password_confirmation,

        :vk_addr, :ok_addr, :tw_addr,
        :fb_addr, :ig_addr, :pt_addr,
        :gp_addr
      )

      if _params[:password].blank? && _params[:password_confirmation].blank?
        _params = _params.except(:password, :password_confirmation)
      end

      _params
    end

    def _t(name)
      t("user_room.controllers.users.#{name}")
    end
  end # UsersController
end # UserRoom
