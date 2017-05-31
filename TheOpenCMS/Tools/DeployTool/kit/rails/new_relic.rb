class DeployKit
  def new_relic_config_copy
    return unless has_new_relic?

    template_upload \
      "services/newrelic.yml", \
      "#{ app_services_files_path }/newrelic.yml"
  end

  def new_relic_config_link
    return unless has_new_relic?

    remote_exec [
      "rm -rf #{ current_path }/config/newrelic.yml",
      "ln -s  #{ app_services_files_path }/newrelic.yml #{ current_path }/config"
    ]
  end
end
