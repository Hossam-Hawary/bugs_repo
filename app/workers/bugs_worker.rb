require 'sneakers' # don't forget to put gem "sneakers" in your Gemfile
class BugsWorker
  include Sneakers::Worker
  from_queue :examplequeue
  def work(msg)

    data = eval msg
    bug = Bug.generate_new_bug( data[:bug_params], data[:state_params])
    ack! # we need to let queue know that message was received
  end

end

#WORKERS=BugsWorker rake sneakers:run
