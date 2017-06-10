$redis = Redis::Namespace.new("bugs:#{Rails.env}", redis: Redis.new)
