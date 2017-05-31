class DeployKit
  def rake_task
    puts "Insert Rake Task Name and Params:".yellow
    task_options = STDIN.gets.chomp

    remote_exec [
      "cd #{ current_path }",
      "#{ app_env_vars } #{ rake } #{ task_options }"
    ]
  end

  def rake_install
    if rake_version = config.rvm.rake_version
      remote_exec [
        "cd #{ release_path }",
        "gem install rake -v #{ rake_version } --no-ri --no-rdoc"
      ]
    end
  end
end
