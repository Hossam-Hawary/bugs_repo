class BugService

  def self.set_number(token, number)
    $redis.set(token, number)
  end

  def self.get_number(token)
    $redis.get(token)
  end

    #find $redis in intializers/redis.rb
  def self.set_new_bug(token)
    begin
      new_num = ($redis.get(token) || (Api::V1::Bug.app_bugs token).last.try(:number)).to_i + 1
      $redis.set(token, new_num)
        rescue Redis::CannotConnectError
          puts "Connection to Redis failed..... please try again"
      new_num
    end
  end

end
