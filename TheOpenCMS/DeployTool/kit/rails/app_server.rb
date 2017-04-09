class DeployKit
  def app_server_start
    unicorn_start
    puma_start
  end

  def app_server_stop
    unicorn_stop
    puma_stop
  end

  def app_server_restart
    unicorn_restart
    puma_restart
  end

  def app_server_reload
    unicorn_reload
    puma_reload
  end

  def app_server_log
    unicorn_log
    puma_log
  end

  def app_server_err_log
    unicorn_err_log
    puma_err_log
  end
end
