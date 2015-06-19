require 'poseidon'
require 'config'

class Producer
  def initialize(topic)
    # poseidon
    @producer = Poseidon::Producer.new(["#{Config::SERVER}:#{Config::PORT}"], Config::PRO_ID, :type => :sync)
    @topic = topic
  end

  def send(value)
    messages = []
    messages << Poseidon::MessageToSend.new(@topic, value)
    @producer.send_messages(messages)
  end
end
