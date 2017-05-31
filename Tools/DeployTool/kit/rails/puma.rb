class DeployKit
  def puma_config_file
    'puma.rb'
  end

  def puma_config_copy
    return unless has_puma?

    template_upload \
      "services/#{ puma_config_file }", \
      "#{ app_services_files_path }/#{ puma_config_file }"
  end

  def puma_start
    return unless has_puma?

    unless remote_file_exists?(puma_pid)
      remote_exec [
        "cd #{ current_path }",
        "#{ rvm_ruby } #{ bin_puma } -d -C #{ current_app_services_files_path }/#{ puma_config_file } -e #{ app_env }"
      ]
    else
      puts "puma is already started: PID #{ puma_read_pid }".upcase.green
    end
  end

  def puma_stop
    return unless has_puma?

    if remote_file_exists?(puma_pid)
      remote_exec "kill -QUIT #{ puma_read_pid }"
      remote_exec "rm #{ puma_pid }"
    else
      puts "puma is already stopped".upcase.red
    end
  end

  def puma_force_stop
    return unless has_puma?

    if remote_file_exists?(puma_pid)
      remote_exec "kill -TERM #{ puma_read_pid }"
      remote_exec "rm #{ puma_pid }"
    else
      puts "puma is already stopped".upcase.red
    end
  end

  def puma_reload
    return unless has_puma?

    if remote_file_exists?(puma_pid)
      remote_exec "kill -USR2 #{ puma_read_pid }"
    else
      puts "puma is stopped".upcase.red
    end
  end

  def puma_restart
    return unless has_puma?

    puma_stop
    puma_start
  end

  def puma_log
    return unless has_puma?

    remote_exec [
      "cd #{ current_path }",
      "tail -n 100 log/puma.log"
    ]
  end

  def puma_err_log
    return unless has_puma?

    remote_exec [
      "cd #{ current_path }",
      "tail -n 100 log/puma.errors.log"
    ]
  end

  # helpers

  def puma_pid
    return unless has_puma?

    "#{ current_path }/tmp/pids/puma.pid"
  end

  def puma_read_pid
    return unless has_puma?

    remote_exec("cat #{ puma_pid }").to_s.strip
  end

  def puma_status
    return unless has_puma?

    remote_exec "ps aux | grep puma"
  end
end
