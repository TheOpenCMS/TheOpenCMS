redis_url    = Settings.redis.url
redis_port   = Settings.redis.port
sq_namespace = Settings.sidekiq.namespace

SQ_ERR_LOGGER = Logger.new("#{ Rails.root }/log/sidekiq_errors.log")

puts "Sidekiq: will try to connect to Redis on port: #{ redis_port }".cyan

Sidekiq.configure_client do |config|
  config.redis = {
    url: redis_url,
    namespace: sq_namespace
  }
end

Sidekiq.configure_server do |config|
  config.redis = {
    url: redis_url,
    namespace: sq_namespace
  }
end

Sidekiq.configure_server do |config|
  config.error_handlers << Proc.new do |ex,context|
    # ExceptionNotifier.notify_exception(ex, data: { sidekiq: context })
    SQ_ERR_LOGGER.error "#{ex}\n#{context}\n\n"
  end
end
