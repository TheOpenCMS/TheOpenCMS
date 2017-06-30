class ArticleACL < AuthorizeIt::ACLPermits::Base
  def can_perform?
    return true if @user.admin?

    acl = %w[index show print new edit create update destroy]
    acl.include?(@action.to_s)
  end
end
