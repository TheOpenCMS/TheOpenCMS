# include ::UserRoom::UsersController
module UserRoom
  module UsersController
    extend ActiveSupport::Concern

    included do
      layout -> { layout_template }
      include ::UserRoom::UserAvatarActions

      skip_before_action :authenticate_user!, if: :skip_authenticate_user?
      skip_before_action :authorize_action!,  if: :skip_authorize_action?
      skip_before_action :set_resource!,      if: :skip_set_resource?
      skip_before_action :authorize_owner!,   if: :skip_authorize_owner?
      skip_before_action :authorize_admin!,   if: :skip_authorize_admin?
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

    def change_email
      if @user.update(permitted_params)
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

    def set_resource!
      user_id = params[:id] || params[:user_id]
      @user = ::User.where(login: user_id).first
    end

    def layout_template
      public_actions = %w[show index]
      return 'user_room_frontend' if public_actions.include?(action_name)
      'user_room_backend'
    end

    def _t(name)
      t("user_room.controllers.users.#{name}")
    end

    protected

    def skip_authenticate_user?
      %w[index show].include?(action_name)
    end

    def skip_authorize_action?
      skipped_actions =
        %w[index show edit update profile change_password change_email] +
        ::UserRoom::UserAvatarActions::AVATAR_ACTIONS_NAMES

      skipped_actions.include?(action_name)
    end

    def skip_set_resource?
      %w[index profile].include?(action_name)
    end

    def skip_authorize_owner?
      %w[index show profile].include?(action_name)
    end

    def skip_authorize_admin?
      skipped_actions =
        %w[index show edit update profile change_password change_email] +
        ::UserRoom::UserAvatarActions::AVATAR_ACTIONS_NAMES

      skipped_actions.include?(action_name)
    end

  end # UsersController
end # UserRoom
