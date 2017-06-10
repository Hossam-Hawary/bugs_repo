require 'sneakers' # don't forget to put gem "sneakers" in your Gemfile
require 'sneakers/runner'
class Processor
  include Sneakers::Worker
  from_queue :examplequeue
  def work(msg)
    puts "Msg received: " + msg
  end
end


  def self.subscribe_consumer(queue)
    puts "**** will subscripe"
    r = Sneakers::Runner.new([Processor])
    r.run
    # queue.subscribe(:block => true) do |delivery_info, properties, payload|
    #   # json_information_message = JSON.parse(payload);
    #   puts "*"*20
    #   puts delivery_info,properties, payload
    #   puts "*"*20
    # end
  end
