class Ownership::Article < AuthorizeIt::Ownership::Base
  def owner?
    return true if @user.admin?
    @resource.user == @user
  end
end
