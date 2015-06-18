require 'poseidon'

module Config
  SERVER = 'kafka'
  PORT = 9092
  TOPIC = 'sol'
end

class App < Sinatra::Base
  enable :logging

  get '/' do
    'Hello from docker!'
  end

  get '/sol/:sol' do
    logger.info "Hello world."
    "Hello #{params['sol']}!"
  end
end

# class Consumer
#   consumer = Poseidon::PartitionConsumer.new("my_test_consumer", Config::SERVER, Config::PORT, Config::TOPIC, 0, :earliest_offset)
#   loop do
#     messages = consumer.fetch
#     messages.each do |m|
#       puts m.value
#     end
#   end
# end

# class Producer
#   producer = Poseidon::Producer.new(["#{Config::SERVER}:#{Config::PORT}"], "my_test_producer")

#   messages = []
#   messages << Poseidon::MessageToSend.new("topic1", "value1")
#   messages << Poseidon::MessageToSend.new("topic2", "value2")
#   producer.send_messages(messages)
# end
