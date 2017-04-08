module Notifications
  def self.configure(&block)
    yield @config ||= Notifications::Configuration.new
  end

  def self.config
    @config
  end

  # Configuration class
  class Configuration
    include ActiveSupport::Configurable

    config_accessor :default_type, :default_types
  end

  configure do |config|
    config.default_type = :html # :json
    config.default_types = %w[ notice alert error ]
  end
end
