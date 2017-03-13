require 'slim'
require_relative 'notifications_config'
_root_ = File.expand_path('../../', __FILE__)

module Notifications
  class Engine < Rails::Engine; end
end

# TODO: Rework it with `autoload`
%w[ localized_errors ].each do |concern|
  require "#{ _root_ }/app/models/concerns/#{ concern }.rb"
end
