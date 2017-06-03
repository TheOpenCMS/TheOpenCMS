# include ::UserRoom::ControllerCallbacks
module UserRoom
  module ControllerCallbacks
    extend ActiveSupport::Concern

    included do
      before_action :authenticate_user!, if: :needs_authenticate_user?
      before_action :authorize_action!,  if: :needs_authorize_action?
      before_action :set_resource!,      if: :needs_set_resource?
      before_action :authorize_owner!,   if: :needs_authorize_owner?
    end

    protected

    def needs_authenticate_user?
      !%w[index show].include?(action_name)
    end

    def needs_authorize_action?
      skipped_actions =
        %w[index show edit update profile change_password] +
        ::UserRoom::ControllerAvatarActions::AVATAR_ACTIONS_NAMES

      !skipped_actions.include?(action_name)
    end

    def needs_set_resource?
      !%w[index profile].include?(action_name)
    end

    def needs_authorize_owner?
      !%w[index show profile].include?(action_name)
    end

    def needs_authorize_admin?
      skipped_actions =
        %w[index show edit update profile change_password] +
        ::UserRoom::ControllerAvatarActions::AVATAR_ACTIONS_NAMES

      !skipped_actions.include?(action_name)
    end

  end # ControllerRestrictions
end
