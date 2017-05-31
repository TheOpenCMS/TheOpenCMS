class DeployKit
  def redis_config_file
    'redis.config'
  end

  def redis_config_copy
    return unless has_redis?

    template_upload \
      "services/#{ redis_config_file }", \
      "#{ app_services_files_path }/#{ redis_config_file }"
  end

  def redis_start
    return unless has_redis?

    remote_exec [
      "redis-server #{ current_app_services_files_path }/#{ redis_config_file }",
      "redis-server -v"
    ]
  end

  def redis_stop
    return unless has_redis?

    remote_exec "redis-cli -h localhost -p #{ config.redis.port } shutdown"
  end

  def redis_restart
    return unless has_redis?

    redis_stop
    redis_start
  end

  def redis_status
    return unless has_redis?

    remote_exec "ps aux | grep redis"
    remote_exec "cat #{ current_path }/tmp/pids/redis.pid"
  end

  def redis_log
    return unless has_redis?

    remote_exec "tail -f -n 100 #{ shared_logs_path }/redis.log"
  end
end
