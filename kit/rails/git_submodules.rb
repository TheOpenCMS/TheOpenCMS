class DeployKit
  def git_submodules_init
    remote_exec [
      "cd #{ release_path }",
      "git submodule init"
    ]
  end

  def git_submodules_update
    remote_exec [
      "cd #{ release_path }",
      "git submodule update"
    ]
  end

  def git_submodules_install
    dirs = config.git.submodules
    return if dirs.nil? || dirs.empty?

    dirs.each do |dir|
      remote_exec [
        "cd #{ release_path }/#{ dir }",
        "git submodule init",
        "git submodule update"
      ]
    end
  end
end
