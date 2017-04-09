class DeployKit
  def git_init_repo
    remote_exec [
      "cd #{ release_path }",
      "git clone #{ config.app.repo } ."
    ]
  end

  def git_checkout_branch
    remote_exec [
      "cd #{ release_path }",
      "git pull",
      "git checkout #{ config.app.branch }"
    ]
  end

  def git_status
    remote_exec [
      "cd #{ release_path }",
      "git status"
    ]
  end

  def git_reset_hard
    remote_exec [
      "cd #{ release_path }",
      "git reset --hard"
    ]
  end

  def git_submodules_file_copy
    return if development?

    template_upload \
      "submodules.erb", \
      "#{ release_path }/.gitmodules"
  end
end
