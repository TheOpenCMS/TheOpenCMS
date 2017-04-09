class DeployKit
  def sidekiq_config_file
    'sidekiq.yml'
  end

  def sidekiq_pid
    "#{ shared_pids_path }/sidekiq.pid"
  end

  def sidekiq_config_copy
    return unless has_sidekiq?

    template_upload \
      "services/#{ sidekiq_config_file }", \
      "#{ app_services_files_path }/#{ sidekiq_config_file }"
  end

  def sidekiq_start
    return unless has_sidekiq?

    sidekiq_exec = (remote_exec [
      "cd #{ current_path }",
      "which sidekiq"
    ]).chomp

    return if sidekiq_exec.empty?

    until process_exists?(sidekiq_pid) do
      puts 'Trying to start Sidekiq'.red

      remote_exec [
        "cd #{ current_path }",
        "#{ app_env_vars } #{ sidekiq_exec } -d -e #{ app_env } -C #{ app_services_files_path }/#{ sidekiq_config_file }"
      ]
    end

    puts "SIDEKIQ is started already".upcase.green
  end

  def sidekiq_stop
    return unless has_sidekiq?

    sidekiqctl_exec = (remote_exec [
      "cd #{ current_path }",
      "which sidekiqctl"
    ]).chomp

    return if sidekiqctl_exec.empty?

    if remote_file_exists?(sidekiq_pid)
      remote_exec [
        "cd #{ current_path }",
        "#{ sidekiqctl_exec } stop #{ sidekiq_pid }"
      ]

      remote_exec("rm #{ sidekiq_pid }") if remote_file_exists?(sidekiq_pid)
    else
      puts "SIDEKIQ is stopped already".upcase.red
    end
  end

  def sidekiq_restart
    return unless has_sidekiq?

    sidekiq_stop
    sidekiq_start
  end

  def sidekiq_info
    return unless has_sidekiq?

    remote_exec "ps aux | grep sidekiq"
    remote_exec  "cat #{ shared_pids_path }/sidekiq.pid"
  end

  def sidekiq_status
    return unless has_sidekiq?

    remote_exec "ps aux | grep sidekiq"
  end

  def sidekiq_log
    return unless has_sidekiq?

    remote_exec "tail -f -n 100 #{ shared_logs_path }/sidekiq.log"
  end

  def sidekiq_errors_log
    return unless has_sidekiq?

    remote_exec "tail -f -n 100 #{ shared_logs_path }/sidekiq_errors.log"
  end
end
