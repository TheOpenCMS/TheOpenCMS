class DeployKit
  def bin_path
    config.tools.binstubs ? 'bin/' : ''
  end

  def bin_rails
    "#{ bin_path }rails"
  end

  def bin_rake
    "#{ bin_path }rake"
  end

  def bin_whenever
    "#{ bin_path }whenever"
  end

  def bin_sidekiq
    "#{ bin_path }sidekiq"
  end

  def bin_sidekiqctl
    "#{ bin_path }sidekiqctl"
  end

  def bin_puma
    "#{ bin_path }puma"
  end

  def bin_unicorn
    config.tools.binstubs           ? \
      "#{ bin_path }unicorn_rails" : \
      remote_exec("cd #{ current_path } && which unicorn_rails").chomp
  end
end
