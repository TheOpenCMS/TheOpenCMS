class ArticleACL::Shared < AuthorizeIt::ACLPermits::Base
  def can_perform?
    return true if @user.admin?

    acl = %w[index show print edit update destroy]
    acl.include?(@controller.action_name)
  end
end
