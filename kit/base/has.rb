class DeployKit
  def has_ts?
    config.tools.sphinx
  end

  def has_redis?
    config.tools.redis
  end

  def has_sidekiq?
    config.tools.sidekiq
  end

  def has_whenever?
    config.tools.whenever
  end

  def has_new_relic?
    config.tools.new_relic
  end

  def has_letsencript?
    config.tools.letsencript
  end

  def has_unicorn?
    config.tools.app_server.downcase == 'unicorn'
  end

  def has_puma?
    config.tools.app_server.downcase == 'puma'
  end

  def has_psql?
    config.db.adapter.downcase == 'postgresql'
  end

  def has_mysql?
    %w[ mysql mysql2 ].include?(config.db.adapter.downcase)
  end
end
