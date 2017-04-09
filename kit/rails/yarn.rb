class DeployKit
  def yarn_install
    # sudo_remote_exec [
    #   "curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -",
    #   'echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list',
    #   'apt-get update',
    #   'apt-get install yarn'
    # ]
  end

  def yarn_bundle
    remote_exec [
      "cd #{current_path}",
      "yarn install"
    ]
  end
end
