class WelcomeACL < AuthorizeIt::ACLPermits::Base
  def can_perform?
    return true if @user.admin?

    acl = %w[index create_new]
    acl.include?(@action.to_s)
  end
end
