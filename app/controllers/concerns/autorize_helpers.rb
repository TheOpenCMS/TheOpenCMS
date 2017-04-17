module AutorizeHelpers
  extend ActiveSupport::Concern

  included do
    private
  
    def authorize_owner!
      return true if current_user.try(:admin?)
      return true if current_user == authorize_resource

      redirect_back fallback_location: root_path,
        flash: {error: 'Access Denied'}
    end

    def authorize_admin!
      return true if current_user.try(:admin?)

      redirect_back fallback_location: root_path,
        flash: {error: 'Access Denied'}
    end

    def authorize_resource
      begin
        var_name = self.class.try(:class_variable_get, :@@authorize_resource_name)
        instance_variable_get("@#{var_name}")
      rescue; end
    end
  end

  class_methods do
    def authorize_resource_name name
      self.class_variable_set(:@@authorize_resource_name, name)
    end
  end
end
