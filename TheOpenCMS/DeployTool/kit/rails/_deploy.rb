class DeployKit
  def deploy!
    startup_authorize_deployer
    startup_create_base_dirs
    app_create_tmp_folders
    startup_copy_ssh_files

    release_create_dir

    git_init_repo
    git_checkout_branch

    rvm_set_init_files
    rvm_install_ruby_env

    copy_app_settings_files
    copy_app_services_files
    copy_app_database_config

    copy_app_static_files
    ssl_files_copy

    link_database_config
    link_settings_files
    link_services_files
    link_shared_dirs

    git_submodules_install

    app_bundle
    yarn_bundle

    app_database_create
    app_database_migrate
    app_assets_precompile

    link_current_release

    new_relic_config_copy
    new_relic_config_link

    redis_start

    ts_config
    ts_index
    ts_restart
    cron_restart

    app_server_restart
    nginx_restart

    release_cleanup
    letsencript_info

    sidekiq_restart
  end
end
