class DeployKit
  def stat_disk_space
    remote_exec 'df -h'
  end
end
