class DeployKit
  def unicorn_config_file
    'unicorn.rb'
  end

  def unicorn_config_copy
    return unless has_unicorn?

    template_upload \
      "services/#{ unicorn_config_file }", \
      "#{ app_services_files_path }/#{ unicorn_config_file }"
  end

  def unicorn_start
    return unless has_unicorn?

    unless remote_file_exists?(unicorn_pid)
      remote_exec [
        "cd #{ current_path }",
        "#{ rvm_ruby } #{ bin_unicorn } -D -c #{ current_app_services_files_path }/#{ unicorn_config_file } -E #{ app_env }"
      ]
    else
      puts "Unicorn is already started: PID #{ unicorn_read_pid }".upcase.green
    end
  end

  def unicorn_stop
    return unless has_unicorn?

    if remote_file_exists?(unicorn_pid)
      remote_exec "kill -QUIT #{ unicorn_read_pid }"
      remote_exec "rm #{ unicorn_pid }"
    else
      puts "Unicorn is already stopped".upcase.red
    end
  end

  def unicorn_force_stop
    return unless has_unicorn?

    if remote_file_exists?(unicorn_pid)
      remote_exec "kill -TERM #{ unicorn_read_pid }"
      remote_exec "rm #{ unicorn_pid }"
    else
      puts "Unicorn is already stopped".upcase.red
    end
  end

  def unicorn_reload
    return unless has_unicorn?

    if remote_file_exists?(unicorn_pid)
      remote_exec "kill -USR2 #{ unicorn_read_pid }"
    else
      puts "Unicorn is stopped".upcase.red
    end
  end

  def unicorn_restart
    return unless has_unicorn?

    unicorn_stop
    unicorn_start
  end

  def unicorn_log
    return unless has_unicorn?

    remote_exec [
      "cd #{ current_path }",
      "tail -n 100 log/unicorn.log"
    ]
  end

  def unicorn_err_log
    return unless has_unicorn?

    remote_exec [
      "cd #{ current_path }",
      "tail -n 100 log/unicorn.errors.log"
    ]
  end

  def unicorn_status
    return unless has_unicorn?

    remote_exec "ps aux | grep unicorn"
    remote_exec "cat #{ unicorn_pid }"
  end

  # helpers

  def unicorn_pid
    return unless has_unicorn?

    "#{ current_path }/tmp/pids/unicorn.pid"
  end

  def unicorn_read_pid
    return unless has_unicorn?

    remote_exec("cat #{ unicorn_pid }").to_s.strip
  end
end
