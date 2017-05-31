class DeployKit
  def whenever_config_file
    'schedule.rb'
  end

  def whenever_config_path
    "#{ app_services_files_path }/#{ whenever_config_file }"
  end

  def cron_config_copy
    return unless has_whenever?

    template_upload \
      "services/#{ whenever_config_file }",
      "#{ app_services_files_path }/#{ whenever_config_file }"
  end

  def cron_start
    return unless has_whenever?

    to_exec = ssh_escape <<-EOS
      #{ bundle_exec } #{ bin_whenever }
        --set 'rvm_bin=rvm&environment=#{ app_env }'
        --load-file '#{ whenever_config_path }'
        --update-crontab #{ app_name }
    EOS

    remote_exec ["cd #{ current_path }", to_exec]
  end

  def cron_stop
    return unless has_whenever?

    remote_exec [
      "cd #{ current_path }",
      "#{ bundle_exec } #{ bin_whenever } --clear-crontab #{ app_name }"
    ]
  end

  def cron_restart
    return unless has_whenever?

    cron_stop
    cron_start
  end

  alias :cron_update :cron_restart

  def cron_status
    return unless has_whenever?

    remote_exec "crontab -l"
  end

  def cron_clean
    return unless has_whenever?

    remote_exec "crontab -r"
  end

  def cron_upload!
    return unless has_whenever?

    prepare_app_services_files_path!

    template_upload(
      "services/schedule.rb",
      "#{ app_services_files_path }/schedule.rb"
    )
  end

  def cron_log
    return unless has_whenever?

    remote_exec "tail -f -n 100 #{ shared_logs_path }/cron.log"
  end

  def cron_errors_log
    return unless has_whenever?

    remote_exec "tail -f -n 100 #{ shared_logs_path }/cron.errors.log"
  end
end
