# include ::UserRoom::UsersController
module UserRoom
  module UsersController
    extend ActiveSupport::Concern

    included do
      layout -> { layout_template }
      include ::UserRoom::ControllerAvatarActions
      include ::UserRoom::ControllerCallbacks
    end

    ##########################################
    ### Public actions
    ##########################################

    def index
      @users = ::User
        .max2min(:created_at)
        .simple_sort(params)
        .pagination(params)

      @users_count = ::User.count
    end

    def show; end

    ##########################################
    ### Restricted actions
    ##########################################

    def edit; end

    def update
      @user.assign_attributes(permitted_params)
      @user.content_processing!(current_user)

      if @user.save
        sign_in(@user, bypass: true) if permitted_params[:password].present?
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

    def _t(name)
      t("user_room.controllers.users.#{name}")
    end

  end # UsersController
end
