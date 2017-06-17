# include ::UserRoom::ControllerCallbacks
module UserRoom
  module ControllerCallbacks
    extend ActiveSupport::Concern

    included do
      before_action :authenticate_user!, if: :needs_authenticate_user?
      before_action :set_role!,          if: :needs_set_role?
      before_action :authorize_action!,  if: :needs_authorize_action?

      before_action :set_resource_class!, if: :needs_set_resource_class?
      before_action :set_resource!,       if: :needs_set_resource?

      before_action :authorize_owner!,   if: :needs_authorize_owner?
    end

    protected

    ################################################
    # Authorization
    ################################################

    def authorize_action!
      acl = {
        user:  %w[index show edit update] + user_avatar_actions,
        admin: %w[index show edit update] + user_avatar_actions
      }
      authorized = acl[@role].include?(action_name)
      authorization_exception!('Action is not allowed to perform') unless authorized
    end

    def set_resource!
      user_id = params[:id] || params[:user_id]
      @user = ::User.where(login: user_id).first
    end

    def authorize_owner!
      return true if current_user.admin?
      authorized = @resource == current_user
      authorization_exception!('Owner required') unless authorized
    end

    ################################################
    # Do We Need to Perform a Callback?
    ################################################

    def needs_authenticate_user?
      except_actions = %w[index show]
      !except_actions.include?(action_name)
    end

    def needs_set_role?
       except_actions = %w[index]
      !except_actions.include?(action_name)
    end

    def needs_authorize_action?
      except_actions = %w[index show]
      !except_actions.include?(action_name)
    end

    def needs_set_resource_class?
       except_actions = %w[]
      !except_actions.include?(action_name)
    end

    def needs_set_resource?
      except_actions = %w[index show] + user_avatar_actions
      !except_actions.include?(action_name)
    end

    def needs_authorize_owner?
      except_actions = %w[index show profile]
      !except_actions.include?(action_name)
    end

    def needs_authorize_admin?
      except_actions = %w[index show] + user_avatar_actions
      !except_actions.include?(action_name)
    end

    def user_avatar_actions
      ::UserRoom::ControllerAvatarActions::AVATAR_ACTIONS_NAMES
    end
  end # ControllerRestrictions
end
