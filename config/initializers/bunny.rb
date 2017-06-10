

class RabbitMg
  #CLOUDAMQP_URL = ENV['CLOUDAMQP_URL'] #in production

  CLOUDAMQP_URL = 'amqp://uccpeoea:3zZzuv8Iebb6h4lGR9vqPXaVqPsOHt9c@orangutan.rmq.cloudamqp.com/uccpeoea'
  def self.init_rabbit_mq

    #Returns a connection instance
    @@conn = Bunny.new CLOUDAMQP_URL #ENV['CLOUDAMQP_URL'] in production
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
  end

  def self.send_message(information_message)
    @@x.publish(information_message,
      :timestamp      => Time.now.to_i,
      :routing_key    => "new_bugs"
    )
  end


  def self.get_queue
    @@queue
  end

  def self.close
    @@conn.close
  end
end

RabbitMg.init_rabbit_mq
#RabbitMg.close
