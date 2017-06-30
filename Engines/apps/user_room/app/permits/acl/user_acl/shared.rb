class UserACL::Shared < ActivePermits::ACLPermits::Base
  def can_perform?
    return true if @user.admin?

    user_avatar_actions = ::UserRoom::ControllerAvatarActions::AVATAR_ACTIONS_NAMES
    acl = %w[index show edit update] + user_avatar_actions
    acl.include?(@action.to_s)
  end
end
