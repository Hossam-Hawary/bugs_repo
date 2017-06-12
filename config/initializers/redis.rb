$redis = Redis::Namespace.new("bugs:#{Rails.env}", redis: Redis.new(:host => ENV.fetch('REDIS_HOST', 'localhost')))
