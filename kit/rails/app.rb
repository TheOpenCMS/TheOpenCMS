class DeployKit
  def app_create_tmp_folders
    remote_exec [
      "mkdir -p #{ shared_cache_path }",
      "mkdir -p #{ shared_pids_path }",
      "mkdir -p #{ shared_sessions_path }",
      "mkdir -p #{ shared_sockets_path }",
      "mkdir -p #{ shared_tmp_path }/binlog",
    ]
  end

  def app_bundle
    remote_exec [
      "cd #{ release_path }",
      bundle_install
    ]
  end

  def app_update_bin
    remote_exec [
      "cd #{ release_path }",
      "#{ rake } rails:update:bin"
    ]
  end

  def app_database_create
    remote_exec [
      "cd #{ release_path }",
      "#{ app_env_vars } #{ rake } db:create"
    ]
  end

  def app_database_migrate
    remote_exec [
      "cd #{ release_path }",
      "#{ app_env_vars } #{ rake } db:migrate"
    ]
  end

  def app_assets_precompile
    return unless config.tools.assets_precompile

    remote_exec [
      "cd #{ release_path }",
      "ls -al public/assets"
    ]

    remote_exec [
      "cd #{ release_path }",
      "ls -al public/assets",
      "#{ app_env_vars } #{ rake } assets:precompile"
    ]
  end

  def app_log
    remote_exec [
      "cd #{ current_path }/log",
      "tail -n 100 #{ app_env }.log"
    ]
  end

  def app_stop
    puma_stop
    unicorn_stop

    sidekiq_stop
    redis_stop
    cron_stop
    ts_stop
  end

  def app_restart
    ts_restart
    cron_restart
    redis_restart
    sidekiq_restart

    unicorn_restart
    puma_restart
  end

  def app_status
    ts_status
    sidekiq_status
    redis_status
    cron_status

    unicorn_status
    puma_status
  end
end
