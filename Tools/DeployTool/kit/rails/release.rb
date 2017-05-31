class DeployKit
  def release_dir_name
    branch_name = config.app.branch

    new_release_dir  = Time.now.strftime("%Y-%m-%d--%H-%M-%S--#{ branch_name }")
    release_dir_name = ENV['DEPLOY_DIR'] || new_release_dir

    @release_dir_name ||= release_dir_name
  end

  def release_create_dir
    remote_exec [
      "cd #{ app_root_path }/RELEASES",
      "mkdir -p #{ release_dir_name }"
    ]

    time_stamp = Time.now.strftime("%Y-%m-%d--%H-%M-%S")
    local_exec "echo '#{ time_stamp } | DEPLOY_ENV=#{ app_env } DEPLOY_DIR=#{release_dir_name}' >> RELEASES.txt"
  end

  def release_marker
    remote_exec [
      "cd #{ release_path }",
      "git log --oneline -n 1 > public/RELEASE.txt"
    ]
  end

  def release_cleanup
    res = remote_exec [
      "cd #{ app_root_path }/RELEASES",
      "ls -ltx"
    ]

    keep_size = 5

    rels_ary = res.split(" ")
    keep_ary = rels_ary.first(keep_size)
    del_ary  = rels_ary - keep_ary

    puts res.split(" ").join("\n").light_blue
    puts keep_ary.join("\n").light_green
    puts del_ary.join("\n").light_red

    del_cmds = del_ary.map do |dir|
      "rm -rf #{ app_root_path }/RELEASES/#{ dir }"
    end

    remote_exec del_cmds
  end
end
