class DeployKit
  def kit_templates_path
    '__TEMPLATES__'
  end

  def kit_configs_path
    '__ENV__'
  end

  # COMMON PATHS

  def app_root_path
    "#{ config.app.root }/#{ app_env }"
  end

  def releases_path
    "#{ app_root_path }/RELEASES"
  end

  def shared_path
    "#{ app_root_path }/SHARED"
  end

  def configs_path
    "#{ app_root_path }/ENV"
  end

  def ssl_path
    "#{ app_root_path }/SSL"
  end

  # BASE PATHS

  def release_path
    "#{ releases_path }/#{ release_dir_name }"
  end

  def current_path
    "#{ app_root_path }/current"
  end

  # CONFIGS PATHS

  def env_services
    "#{ app_env }/services"
  end

  def env_settings
    "#{ app_env }/settings"
  end

  def app_services_files_path
    "#{ configs_path }/#{ env_services }"
  end

  def app_settings_files_path
    "#{ configs_path }/#{ env_settings }"
  end

  def release_env_files_path
    "#{ release_path }/config/ENV"
  end

  def current_env_files_path
    "#{ current_path }/config/ENV"
  end

  # CURRENT

  def current_app_services_files_path
    "#{ current_env_files_path }/#{ env_services }"
  end

  def current_app_settings_files_path
    "#{ current_env_files_path }/#{ env_settings }"
  end

  # RELEASE

  def release_env_files_env_path
    "#{ release_env_files_path }/#{ app_env }"
  end

  def release_app_services_files_path
    "#{ release_env_files_path }/#{ env_services }"
  end

  def release_app_settings_files_path
    "#{ release_env_files_path }/#{ env_settings }"
  end

  # SHARED

  def shared_tmp_path
    "#{ shared_path }/tmp"
  end

  def shared_logs_path
    "#{ shared_path }/log"
  end

  def shared_pids_path
    "#{ shared_tmp_path }/pids"
  end

  def shared_sockets_path
    "#{ shared_tmp_path }/sockets"
  end

  def shared_sessions_path
    "#{ shared_tmp_path }/sessions"
  end

  def shared_cache_path
    "#{ shared_tmp_path }/cache"
  end
end
