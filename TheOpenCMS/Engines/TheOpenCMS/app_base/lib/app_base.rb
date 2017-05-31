require 'user_room'
require 'the_publication'

module AppBase
  class Engine < Rails::Engine; end

  # initializer :add_app_base_engine_view_paths do; end

  def self.rails_mailer_views_config!(app)
    voiceless do
      gem_root = ::AppBase::Engine.config.root

      if app.respond_to?(:prepend_view_path)
        app.prepend_view_path("#{ gem_root }/app/mailers")
        app.prepend_view_path("#{ gem_root }/app/mailers/views/app_base")
      end
    end
  end

  def self.rails_app_views_config!(app)
    voiceless do
      gem_root = ::AppTheme::Engine.config.root

      if app.respond_to?(:prepend_view_path)
        app.prepend_view_path("#{ gem_root }/app/views/app_theme")
      end
    end

    voiceless do
      gem_root = ::ThePublication::Engine.config.root

      if app.respond_to?(:prepend_view_path)
        app.prepend_view_path("#{ gem_root }/app/views/the_publication")
      end
    end
  end

  # ::AppBase.rails_app_config!
  def self.rails_app_config!
    app = ::Rails.application

    Dir["#{ app.config.root }/config/ENV/#{ ::Rails.env }/settings/*.yml"].each do |settings_file|
      ::Settings.add_source!(settings_file)
      puts "Settings: #{settings_file}".yellow
    end

    ::Settings.reload!
  end
end
