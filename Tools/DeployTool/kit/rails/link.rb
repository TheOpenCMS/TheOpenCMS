class DeployKit
  def link_settings_files
    remote_exec [
      "rm -rf   #{ release_app_settings_files_path }",
      "mkdir -p #{ release_env_files_env_path }",
      "ln -s    #{ app_settings_files_path } #{ release_env_files_env_path }"
    ]
  end

  def link_services_files
    remote_exec [
      "rm -rf   #{ release_app_services_files_path }",
      "mkdir -p #{ release_env_files_env_path }",
      "ln -s    #{ app_services_files_path } #{ release_env_files_env_path }"
    ]
  end

  def link_database_config
    remote_exec [
      "rm -rf #{ release_path }/config/database.yml",
      "rm -rf #{ release_env_files_env_path }/database.yml",
      "mkdir -p #{ release_env_files_env_path }",
      "ln -s  #{ copy_db_config_path } #{ release_path }/config"
    ]
  end

  def link_shared_dirs
    dirs = config.link.shared
    return if dirs.nil? || dirs.empty?

    dirs.each do |dir|
      remote_exec "mkdir -p #{ shared_path }/#{ dir }"
      remote_exec "rm -rf #{ release_path }/#{ dir }"
      remote_exec "ln -s #{ shared_path }/#{ dir } #{ release_path }/#{ dir }"
    end
  end

  def link_current_release
    remote_exec "rm -rf #{ current_path }"
    remote_exec "ln -s #{ release_path } #{ current_path }"

    remote_exec [
      "touch #{ app_root_path }/RELEASES.log",
      "echo '#{ release_dir_name }' >> #{ app_root_path }/RELEASES.log"
    ]
  end
end
