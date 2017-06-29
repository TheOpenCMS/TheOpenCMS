class Ownership::User < AuthorizeIt::Ownership::Base
  def owner?
    return true if @user.admin?
    @user == @resource
  end
end
