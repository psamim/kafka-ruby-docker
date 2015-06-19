# require 'poseidon'
require 'kafka'
require 'config'

class Producer
  def initialize(topic)
    # kafka-rb
    @producer = Kafka::Producer.new :host => Config::SERVER, :port => Config::PORT, :topic => topic, :polling => 1

    # poseidon
    # @producer = Poseidon::Producer.new(["#{Config::SERVER}:#{Config::PORT}"], Config::PRO_ID, :type => :sync)
    @topic = topic
  end

  def send(value)
    # kafka-rb
    puts "Sending value #{value} to topic #{@topic}."
    message = Kafka::Message.new(value)
    @producer.push(message)

    # poseidon
    # messages = []
    # messages << Poseidon::MessageToSend.new(@topic, value)
    # @producer.send_messages(messages)
  end
end
