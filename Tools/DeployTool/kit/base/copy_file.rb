class DeployKit
  def copy_file_to_remote from, to
    login  = config.ssh.user.deployer.login
    domain = config.ssh.user.deployer.domain
    key    = config.ssh.user.deployer.key

    shell do
      to_exec = <<-EOS
        scp
        -o "ForwardAgent=yes"
        -i #{ key }
        #{ from }
        #{ login }@#{ domain }:#{ to }
      EOS
    end
  end

  def copy_file_from_remote from, to
    login  = config.ssh.user.deployer.login
    domain = config.ssh.user.deployer.domain

    shell do
      to_exec = <<-EOS
        scp
        -o "ForwardAgent=yes"
        -i #{ config.ssh.user.deployer.key }
        #{ login }@#{ domain }:#{ from }
        #{ to }
      EOS
    end
  end
end
