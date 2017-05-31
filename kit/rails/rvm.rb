class DeployKit
  def rvm_set_init_files
    remote_exec [
      "cd #{ release_path }",
      "touch .ruby-version",
      "echo '#{ config.rvm.ruby_version }' > .ruby-version"
    ]

    remote_exec [
      "cd #{ release_path }",
      "touch .ruby-gemset",
      "echo '#{ config.rvm.gemset_name }' > .ruby-gemset"
    ]
  end

  def rvm_install_ruby_env
    # remote_exec "echo 'gem: --no-document' >> ~/.gemrc"

    remote_exec [
      "cd #{ release_path }",
      "rvm autolibs disable && rvm install #{ config.rvm.ruby_version }"
    ]

    if rubygems_version = config.rvm.rubygems_version
      remote_exec [
        "cd #{ release_path }",
        "rvm install rubygems #{ rubygems_version } --force"
      ]
    end

    rake_install
    bundler_install
  end
end
