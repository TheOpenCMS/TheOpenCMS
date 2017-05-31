require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Rails51
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    ::AppBase.rails_app_config!

    ActiveSupport.on_load(:action_mailer) do
      ::AppBase.rails_mailer_views_config!(self)
    end

    ActiveSupport.on_load(:action_controller) do
      ::AppBase.rails_app_views_config!(self)
    end
  end
end
