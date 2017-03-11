module UserRoom
  def self.configure(&block)
    yield @config ||= UserRoom::Configuration.new
  end

  def self.config
    @config
  end

  # Configuration class
  class Configuration
    include ActiveSupport::Configurable

    config_accessor :storage_prefix
  end

  configure do |config|
    config.storage_prefix = ''
  end
end

# config/initializers/attached_images.rb

# UserRoom.configure do |config|
#   config.storage_prefix = 'my_project'
# end

# UserRoom.config.storage_prefix