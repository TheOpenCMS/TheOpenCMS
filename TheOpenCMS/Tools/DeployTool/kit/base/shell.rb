class DeployKit
  def sudoer
    config.ssh.user.sudo
  end

  def deployer
    config.ssh.user.deployer
  end

  def shell cmds = nil
    to_exec = cmds_to_ary(cmds)
    to_exec = cmds_prepare(to_exec)
    to_exec = block_given? ? yield(to_exec) : to_exec
    to_exec = cmds_compact([to_exec]).shift

    return if to_exec.size.zero?

    log_cmds(cmds)
    log(to_exec)

    return if ENV['DEPLOY_DEBUG']

    IO.popen(to_exec).inject('') do |res, fd|
      puts(fd)
      res << fd
    end
  end

  def local_exec cmds
    shell cmds
  end

  def sudo_local_exec cmds
    local_exec cmds
  end

  def remote_exec cmds
    shell cmds do |cmds|
      to_exec = <<-EOS
        ssh
        -t
        -o "ForwardAgent=yes"
        -i #{ config.ssh.user.deployer.key }
        -l #{ config.ssh.user.deployer.login }
        #{ config.ssh.user.deployer.domain }
        "/bin/bash -l -c '#{ cmds }'"
      EOS
    end
  end

  def sudo_remote_exec cmds
    shell cmds do |cmds|
      to_exec = <<-EOS
        ssh
        -t
        -o "ForwardAgent=yes"
        -i #{ config.ssh.user.sudo.key }
        -l #{ config.ssh.user.sudo.login }
        #{ config.ssh.user.sudo.domain }
        "/bin/bash -l -c '#{ cmds }'"
      EOS
    end
  end
end
