class DeployKit
  def ts_config_file
    'thinking_sphinx.yml'
  end

  def ts_config_copy
    return unless has_ts?

    template_upload \
      "services/#{ ts_config_file }", \
      "#{ app_services_files_path }/#{ ts_config_file }"
  end

  def ts_config
    return unless has_ts?

    remote_exec [
      "cd #{ current_path }",
      "#{ app_env_vars } #{ rake } ts:configure"
    ]
  end

  def ts_index
    return unless has_ts?

    remote_exec [
      "cd #{ current_path }",
      "#{ app_env_vars } #{ rake } ts:index"
    ]
  end

  def ts_start
    return unless has_ts?

    remote_exec [
      "cd #{ current_path }",
      "#{ app_env_vars } #{ rake } ts:start"
    ]
  end

  def ts_stop
    return unless has_ts?

    remote_exec [
      "cd #{ current_path }",
      "#{ app_env_vars } #{ rake } ts:stop"
    ]
  end

  def ts_restart
    return unless has_ts?

    ts_stop
    ts_start
  end

  def ts_status
    return unless has_ts?

    remote_exec "ps aux | grep searchd"
    remote_exec "cat #{ shared_pids_path }/searchd.pid"
  end
end
