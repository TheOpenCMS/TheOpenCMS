class DeployKit
  def rvm_do
    rvm    = config.rvm.rvm_path
    ruby   = config.rvm.ruby_version
    gemset = config.rvm.gemset_name

    "#{ rvm } #{ ruby }@#{ gemset } do"
  end

  def rvm_ruby
    "#{ rvm_do } ruby"
  end

  def rvm_gem
    "#{ rvm_do } gem"
  end
end
