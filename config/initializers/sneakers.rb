require 'sneakers'
#LOUDAMQP_URL = ENV['CLOUDAMQP_URL'] #in production
CLOUDAMQP_URL = 'amqp://uccpeoea:3zZzuv8Iebb6h4lGR9vqPXaVqPsOHt9c@orangutan.rmq.cloudamqp.com/uccpeoea'
VHOST='uccpeoea'
opts = {
  :amqp => CLOUDAMQP_URL,
  :vhost => VHOST,
  :exchange => 'new_bugs.exchange',
  :exchange_type => :direct
}
Sneakers.configure(opts)
Sneakers.logger.level = Logger::INFO # the default DEBUG is too noisy
