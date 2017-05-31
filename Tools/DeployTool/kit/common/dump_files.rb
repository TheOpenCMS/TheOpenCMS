class DeployKit
  BASE_DUMP_FILES_PATH = '~/DUMPS'

  def remote_files_paths
    from = config.dump.files.from

    return from   if from.is_a?(Array)
    return [from] if from.is_a?(String) && from.length > 0
    ["#{ shared_path }/public/uploads"]
  end

  def dump_files
    ssh_addr = "#{ config.ssh.user.deployer.login }@#{ config.ssh.user.deployer.domain }"

    from_dirs = remote_files_paths
    to = config.dump.files.to

    from_dirs.each do |from_dir|
      from = "#{ ssh_addr }:#{ from_dir }"

      local_exec [
        "mkdir -p #{ to }",
        "rsync -chavzPr #{ from } #{ to }"
      ]
    end
  end
end
