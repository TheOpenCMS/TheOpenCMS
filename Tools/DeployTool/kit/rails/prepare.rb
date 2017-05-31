class DeployKit
  def prepare_app_services_files_path!
    remote_exec "mkdir -p #{ app_services_files_path }"
  end

  def prepare_app_settings_files_path!
    remote_exec "mkdir -p #{ app_settings_files_path }"
  end
end
