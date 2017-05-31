redis_port = Settings.redis.port
$redis = Redis.new(port: redis_port)

puts "Redis: will try to init on port: #{ redis_port }!".cyan
