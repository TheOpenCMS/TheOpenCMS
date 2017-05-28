%w[
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

  protozaur
].each { |gem_name| require gem_name }

module TheArticle
  class Engine < Rails::Engine
  end
end

gem_root = File.expand_path('../../', __FILE__)
require_relative "#{ gem_root }/config/routes"
