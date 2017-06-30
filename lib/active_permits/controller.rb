module ActivePermits::Controller
  extend ActiveSupport::Concern

  included do
    include ::ActivePermits::PermittedParams
    include ::ActivePermits::ACLPermits::Controller

    helper_method :permitted_params
    helper_method :can_perform?

    private

    def authorize_action!
      authorization_exception!("Action Authorization is required")
    end

    def authorize_owner!
      authorization_exception!("Owner Authorization is required")
    end

    def authorize_fallback_location
      authorization_exception!("Authorization Fallback Location is required")
    end

    def authorization_exception!(message = "ActivePermits / Authorization Exception")
      fail ::ActivePermits::AuthorizationException.new(message)
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
