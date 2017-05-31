class DeployKit
  def startup_authorize_deployer
    puts "YOUR PASS: #{ deployer.password }".red
    remote_exec "mkdir -p ~/.ssh/"

    auth_keys = '~/.ssh/authorized_keys'

    unless remote_file_exists?(auth_keys)
      local_exec  "cat #{ deployer.key_pub } | ssh #{ deployer.login }@#{ deployer.domain } 'cat > #{ auth_keys }'"
    end
  end

  def startup_create_base_dirs
    cmds = [
      "mkdir -p ~/.ssh/",
      "mkdir -p #{ app_root_path }",

      "mkdir -p #{ releases_path } ",
      "mkdir -p #{ configs_path }",
      "mkdir -p #{ shared_path }",
      "mkdir -p #{ ssl_path }",

      "mkdir -p #{ app_services_files_path }",
      "mkdir -p #{ app_settings_files_path }",
    ]

    remote_exec cmds
  end

  def startup_copy_ssh_files
    unless remote_file_exists?('~/.ssh/id_rsa')
      copy_file_to_remote deployer.key, '~/.ssh/id_rsa'
    end

    unless remote_file_exists?('~/.ssh/id_rsa.pub')
      copy_file_to_remote deployer.key_pub, '~/.ssh/id_rsa.pub'
    end

    unless remote_file_exists?('~/.ssh/known_hosts')
      template_upload "ssh_ssl/known_hosts", '~/.ssh/known_hosts'
    end
  end
end

# remote_exec "ssh -T git@github.com"
# remote_exec "ssh -T git@bitbucket.com"
