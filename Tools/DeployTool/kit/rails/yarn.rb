# https://yarnpkg.com/lang/en/docs/install/
class DeployKit
  def yarn_bundle
    remote_exec [
      "cd #{current_path}",
      "yarn install"
    ]
  end
end
