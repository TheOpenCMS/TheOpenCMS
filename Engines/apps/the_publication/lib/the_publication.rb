%w[
  slim
  config

  simple_sort
  the_pagination
  the_string_to_slug
  friendly_id_pack

  mini_magick
  paperclip

  image_tools
  crop_tool

  log_js
  the_notifications
  authorize_it

  protozaur
].each { |gem_name| require gem_name }

module ThePublication
  class Engine < Rails::Engine
    # config.autoload_paths << "#{ config.root }/app/controllers/concerns/the_publication/"
    # config.autoload_paths << "#{ config.root }/app/models/concerns/the_publication/"

    # ActiveSupport.on_load(:action_controller) do
    #   if respond_to?(:prepend_view_path)
    #     gem_root = ::ThePublication::Engine.config.root
    #     prepend_view_path("#{ gem_root }/app/views/the_publication")
    #   end
    # end
  end
end

gem_root = File.expand_path('../../', __FILE__)
require_relative "#{ gem_root }/config/routes"
