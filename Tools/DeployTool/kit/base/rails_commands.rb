class DeployKit
  def rails
    "#{ bundle_exec } #{ bin_rails }"
  end

  def rake
    "#{ bundle_exec } #{ bin_rake }"
  end
end
