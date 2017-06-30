module ActivePermits::PermittedParams
  class Base
    def initialize(controller, options = {})
      @options = options.with_indifferent_access
      @controller = controller
      @params = @controller.params.clone
    end

    def controller_var(variable_name)
      @controller.instance_variable_get(variable_name)
    end
  end

  private

  #################################
  # Controller Helper
  #################################

  def permitted_params(options = {})
    class_name  = options.fetch(:class, self.controller_name).to_s
    action_name = options.fetch(:action, self.action_name).to_s

    options = options.merge({
      class: class_name,
      action: action_name
    })

    permits_class_name = "#{ class_name.singularize }_params/#{ action_name }".classify
    permits_class = (permits_class_name).constantize

    permits_class.new(self, options).permitted_params
  end
end
