class DeployKit
  def without_envs
    ' --without development test '
  end

  def bundler_install
    version = config.rvm.bundler_version

    bundler_install_version = if version && !version.nil?
      "gem install bundler -v #{version} --no-ri --no-rdoc"
    else
      "gem install bundler --no-ri --no-rdoc"
    end

    remote_exec [
      "cd #{ release_path }",
      bundler_install_version
    ]
  end

  def bundle
    "#{ rvm_do } bundle#{ bundler_specific_version }"
  end

  def bundle_install
    "#{ bundle } install #{ without_envs }"
  end

  def bundle_exec
    "#{ bundle } exec"
  end

  def bundler_specific_version
    version = config.rvm.bundler_version
    return '' unless version && !version.nil?
    " _#{version}_ "
  end
end
