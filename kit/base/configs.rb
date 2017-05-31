class DeployKit
  def config
    ::Settings
  end

  def configs_load!
    ::Config.load_and_set_settings('')
    puts "#{ ::KIT_ROOT }/#{ kit_configs_path }/#{ app_env }/*.yml"

    Dir["#{ ::KIT_ROOT }/#{ kit_configs_path }/#{ app_env }/*.yml"].each do |settings_file|
      ::Settings.add_source!(settings_file)
      puts ('Settings: LOAD FILE => `' + settings_file + '`').light_cyan
    end

    ::Settings.reload!
  end
end
