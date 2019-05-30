Rails.application.config.autoload_paths += Dir[File.join(Rails.root, "lib", "redis.rb")].each {|l| require l }
redis_options = {redis_connection: $redis}
PHOTO_LIKE_COUNT = Leaderboard.new('photo_like_count',Leaderboard::DEFAULT_OPTIONS, redis_options)
PHOTO_LIKE_COUNT.page_size = 12