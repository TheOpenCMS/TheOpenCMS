module AuthorizeIt::Controller
  extend ActiveSupport::Concern

  included do
    private

    def authorize_action!
      authorization_exception!
    end

    def authorize_owner!
      if self.respond_to?(:authorize_owner?)
        return true if authorize_owner?(authorize_user, authorize_resource)
      end

      return true if authorize_user == authorize_resource

      authorization_exception!
    end

    def authorize_user
      current_user
    end

    def authorize_fallback_location
      root_path
    end

    def authorization_exception!
      raise ::AuthorizeIt::NotAuthorized
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
