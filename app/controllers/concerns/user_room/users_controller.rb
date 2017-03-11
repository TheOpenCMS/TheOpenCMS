module UserRoom
  module UsersController
    extend ActiveSupport::Concern

    included do
      layout 'user_room'
      include ::UserRoom::UserAvatarActions

      before_action :set_user_var, only: %w[
        show edit update
        change_password change_email
      ] + ::UserRoom::UserAvatarActions::ACTIONS_NAMES
    end # included

    # Public actions

    def index
      @users = ::User.max2min(:created_at).simple_sort(params).pagination(params)
      @users_count = ::User.count
    end

    def cabinet; end

    def new; @user = ::User.new ; end

    # Restricted actions

    def show; end
    def edit; end

    def autologin
      user = ::User.where(login: params[:id]).first
      sign_in(user, bypass: true)
      redirect_to cabinet_url
    end

    def update
      if @user.update(user_params)
        sign_in(@user, bypass: true) if user_params[:password].present?
        redirect_to edit_user_path(@user), notice: "Изменения сохранены"
      else
        @user.reload
        render 'users/edit'
      end
    end

    def change_password
      @user.send_reset_password_instructions
      redirect_to url_for([:edit, @user]), notice: "В течение нескольких минут вы получите письмо с инструкциями по смене пароле"
    end

    def change_email
      if @user.update(user_params)
        redirect_to url_for([:edit, @user]), notice: "В течение нескольких минут вы получите письмо с инструкциями по подтверждению вашего нового Email."
      else
        @user.reload
        render 'users/edit'
      end
    end

    private

    def set_user_var
      @user = ::User.where(login: user_id).first
      @owner_check_object = @user
    end

    def user_id
      params[:id] || params[:user_id]
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

  end # UsersController
end # UserRoom
