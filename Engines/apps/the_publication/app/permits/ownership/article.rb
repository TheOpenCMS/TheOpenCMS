class Ownership::Article < ActivePermits::Ownership::Base
  def owner?
    return true if @user.admin?
    @resource.user == @user
  end
end
