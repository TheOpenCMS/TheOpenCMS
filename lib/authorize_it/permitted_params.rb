module AuthorizeIt::PermittedParams
  class Base
    def initialize(controller, options = {})
      @options = options
      @controller = controller
      @params = @controller.params.clone
    end
  end

  private

  def permitted_params(options = {})
    controller_name = options.fetch(:controller, self.controller_name)
    action_name     = options.fetch(:action, self.action_name)

    options = options.merge({
      controller_name: controller_name,
      action_name: action_name
    })

    permit_klass_name = "#{controller_name}_controller/#{action_name}_action_permit".classify
    permit_klass = (permit_klass_name + 's').constantize

    permit_klass.new(self, options).permitted_params
  end
end
