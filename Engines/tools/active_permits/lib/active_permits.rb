require_relative 'active_permits/exceptions'
require_relative 'active_permits/controller'

require_relative 'active_permits/ownership'
require_relative 'active_permits/acl_permits'
require_relative 'active_permits/permitted_params'

require_relative 'active_permits/user'

module ActivePermits
  class Engine < Rails::Engine
    PERMITS_DIR = 'app/permits'

    class << self
      def all_engines
        [Rails.application] + Rails::Engine.subclasses.map(&:instance)
      end

      def engines_with_permissions
        all_engines.select do |engine|
          root_path = engine.root
          dir = "#{ root_path }/#{ PERMITS_DIR }"
          Dir.exist?(dir)
        end
      end

      def load_permittions!
        engines_with_permissions.each do |engine|
          root_path = engine.root
          dir = "#{ root_path }/#{ PERMITS_DIR }"

          ::ActiveSupport::Dependencies.autoload_paths += Dir["#{dir}/**"]

          Dir.glob(File.join(dir, '**/*.rb')).each do |file|
            require_dependency file
          end
        end
      end
    end

    initializer :active_permits_init do
      ::ActivePermits::Engine.load_permittions!
    end
  end
end
