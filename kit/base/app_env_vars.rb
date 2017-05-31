class DeployKit
  def app_env_vars
    "RAILS_ENV=#{ app_env }"
  end
end
