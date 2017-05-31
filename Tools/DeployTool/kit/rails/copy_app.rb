class DeployKit
  def copy_app_settings_files
    prepare_app_settings_files_path!

    files = config.copy_app.settings
    return if files.nil? || files.empty?

    files.compact.each do |file_name|
      template_upload \
        "settings/#{ file_name }", \
        "#{ app_settings_files_path }/#{ file_name }"
    end
  end

  def copy_app_static_files
    files = config.copy_app.static_files
    return if files.nil? || files.empty?

    files.compact.each do |static_file|
      template_upload \
        "static_files/#{ static_file }", \
        "#{ release_path }/public/#{ static_file }"
    end
  end

  def copy_db_config_path
    "#{ configs_path }/#{ app_env }/database.yml"
  end

  def copy_app_database_config
    template_upload "database.yml", copy_db_config_path
  end

  def copy_app_services_files
    prepare_app_services_files_path!

    unicorn_config_copy
    puma_config_copy

    sidekiq_config_copy
    redis_config_copy
    nginx_config_copy
    cron_config_copy
    ts_config_copy
  end
end
