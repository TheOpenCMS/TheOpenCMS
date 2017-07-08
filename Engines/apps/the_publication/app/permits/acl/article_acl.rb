class ArticleACL < ActivePermits::ACLPermits::Base
  def can_perform?
    # The Admin may do everything
    return true if @user.admin?

    # The ACL for Articles
    acl = %w[index show print my new edit create update destroy]

    # Checking for a case when `@action` is a `plain` param
    return acl.include?(@action.to_s) unless @action.is_a?(Array)

    # Checking for a case when `@action` is an Array
    @action.each { |action| return true if acl.include?(action.to_s) }

    # Access denied by default
    false
  end
end
