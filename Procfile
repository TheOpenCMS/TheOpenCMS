redis: redis-server ./config/ENV/development/services/redis.config
sidekiq: RAILS_ENV=development bundle exec bin/sidekiq -e development -C ./config/ENV/development/services/sidekiq.yml
ts_sphinx: RAILS_ENV=development bundle exec rake ts:start NODETACH=true
