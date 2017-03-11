module DeviseHelper
  def resource
    @resource ||= User.new
  end

  def resource_name
    :user
  end

  def resource_class
    User
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
