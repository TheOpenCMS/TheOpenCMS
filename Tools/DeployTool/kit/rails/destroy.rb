class DeployKit
  def destroy_releases
    remote_exec [
      "rm -rf #{ app_root_path }/RELEASES/*"
    ]
  end

  def destroy_app
    timeout = 15
    puts "YOUR APP WILL BE DESTROYED IN #{timeout} SECONDS!".yellow

    timeout.times do
      sleep 1
      print '.'.red
    end

    remote_exec "rm -rf #{ app_root_path }"
  end
end
