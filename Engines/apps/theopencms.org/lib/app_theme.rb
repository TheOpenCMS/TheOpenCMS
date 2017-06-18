require 'app_base'

module AppTheme
  class Engine < Rails::Engine
    initializer :add_app_theme_engine do |app|
      app.middleware.use(::ActionDispatch::Static, "#{ root }/public")
    end
  end
end
