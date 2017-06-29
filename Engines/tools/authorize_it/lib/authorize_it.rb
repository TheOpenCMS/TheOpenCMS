require_relative 'authorize_it/exceptions'
require_relative 'authorize_it/acl_permits'
require_relative 'authorize_it/permitted_params'
require_relative 'authorize_it/controller'
require_relative 'authorize_it/ownership'

module AuthorizeIt
  class Engine < Rails::Engine
    PERMISSIONS_DIR = 'app/permissions'

    class << self
      def all_engines
        [Rails.application] + Rails::Engine.subclasses.map(&:instance)
      end

      def engines_with_permissions
        all_engines.select do |engine|
          root_path = engine.root
          dir = "#{ root_path }/#{ PERMISSIONS_DIR }"
          Dir.exist?(dir)
        end
      end

      def load_permittions!
        engines_with_permissions.each do |engine|
          root_path = engine.root
          dir = "#{ root_path }/#{ PERMISSIONS_DIR }"

          ::ActiveSupport::Dependencies.autoload_paths += Dir["#{dir}/**"]

          Dir.glob(File.join(dir, '**/*.rb')).each do |file|
            require_dependency file
          end
        end
      end
    end

    initializer :authorize_it_init do
      ::AuthorizeIt::Engine.load_permittions!
    end
  end
end
