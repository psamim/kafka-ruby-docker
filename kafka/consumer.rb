# require 'poseidon'
require 'config'
require 'kafka'

class Consumer
  def initialize(topic)
    # kafka-rb
    @consumer = Kafka::Consumer.new host: Config::SERVER, port: Config::PORT, topic: topic, polling: 1

    # poseidon
    # @consumer = Poseidon::PartitionConsumer.new(Config::CONS_ID, Config::SERVER, Config::PORT, topic, 0, :earliest_offset)

    @topic = topic
  end

  def listen
    # kafka-rb
    begin
      consumer.loop do |messages|
        puts "Received"
        puts messages
        yield(messages)
      end
    rescue Exception => e
      puts e.message
      # puts e.backtrace.inspect
      puts "Trying in 5 seconds"
    end

    # poseidon
    # loop do
    #   begin
    #     messages = @consumer.fetch
    #     messages.each do |m|
    #       puts m.value
    #       puts m.offset
    #       yield(m)
    #     end
    #   rescue Exception => e
    #     puts e.message
    #     # puts e.backtrace.inspect
    #     puts "Trying in 5 seconds"
    #     sleep 5
    #   end
    # end
  end
end
