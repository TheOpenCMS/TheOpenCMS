require 'user_room/config'

%w[
  devise
  omniauth-twitter
  omniauth-facebook
  omniauth-vkontakte
  omniauth-google-oauth2
  omniauth-odnoklassniki

  slim
  config

  simple_sort
  the_pagination
  the_string_to_slug
  premailer/rails

  mini_magick
  paperclip

  image_tools
  crop_tool

  log_js
  the_notifications
  authorize_it

  protozaur
].each { |gem_name| require gem_name }

module UserRoom
  class Engine < Rails::Engine
    config.autoload_paths << "#{ config.root }/app/mailers/concerns/"

    initializer :add_user_room_engine_view_paths do
      config.assets.paths << "#{ config.root }/app/mailers/assets/stylesheets"

      ActiveSupport.on_load(:action_mailer) do
        if respond_to?(:prepend_view_path)
          gem_root = ::UserRoom::Engine.config.root
          prepend_view_path("#{ gem_root }/app/mailers/views/user_room/devise")
        end
      end

      ActiveSupport.on_load(:action_controller) do
        if respond_to?(:prepend_view_path)
          gem_root = ::UserRoom::Engine.config.root
          prepend_view_path("#{ gem_root }/app/views/user_room")
        end
      end
    end
  end
end

gem_root = File.expand_path('../../', __FILE__)
require_relative "#{ gem_root }/config/routes"
