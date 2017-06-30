module ActivePermits::Ownership
  class Base
    def initialize(params = {})
      @params = params.with_indifferent_access
      @user = params[:user]
      @resource = params[:resource]
    end
  end

  #################################
  # Model Helper
  #################################

  module User
    def owner?(resource, params = {})
      resource_clss = resource.class
      authorize_owner_class = "Ownership::#{resource_clss}".constantize
      params = params.merge(user: self, resource: resource)
      authorize_owner_class.new(params).owner?
    end
  end
end
