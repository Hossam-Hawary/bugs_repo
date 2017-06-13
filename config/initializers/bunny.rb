

class RabbitMg
  def self.init_rabbit_mq
    begin
      #Returns a connection instance
      @@conn = Bunny.new(
       :host =>  "#{ENV.fetch('RABBITMQ_HOST', 'rabbitmq')}",
       :user =>  "#{ENV.fetch('RABBITMQ_USER', 'guest')}" ,
       :password => "#{ENV.fetch('RABBITMQ_PASSWORD', 'guest')}")
      #The connection will be established when start is called
      @@conn.start
      #create a channel in the TCP connection
      ch = @@conn.create_channel

      #Declare a queue with a given name, examplequeue. In this example is a durable shared queue used.
      @@queue  = ch.queue("new_bugs.queue", :durable => true)

      #For messages to be routed to queues, queues need to be bound to exchanges.
      @@x = ch.direct("new_bugs.exchange", :durable => true)

      #Bind a queue to an exchange
      @@queue.bind(@@x, :routing_key => "new_bugs")

      rescue Bunny::TCPConnectionFailed => e
        puts "Connection to rabbitmq failed.....will try again"
        sleep 1
        RabbitMg.init_rabbit_mq
    end
  end

  def self.send_message(information_message)
    @@x.publish(information_message,
      :timestamp      => Time.now.to_i,
      :routing_key    => "new_bugs"
    )
  end

  def self.subscribe_queue
         @@queue.subscribe(:consumer_tag => "bugs_repo_consumer_001",  :manual_ack => true) do |delivery_info, properties, payload|
           data = eval payload
           bug = Api::V1::Bug.generate_new_bug( data[:bug_params], data[:state_params])
         end
  end

  def self.get_queue
    @@queue
  end

  def self.close
    @@conn.close
  end
end

RabbitMg.init_rabbit_mq
Rails.application.config.after_initialize do
        RabbitMg.subscribe_queue
 end
