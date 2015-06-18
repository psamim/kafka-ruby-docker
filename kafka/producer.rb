require 'poseidon'
require 'config'

class Producer
  def initialize(topic)
    @producer = Poseidon::Producer.new(["#{Config::SERVER}:#{Config::PORT}"], Config::PRO_ID)
    @topic = topic
  end

  def send(value)
    messages = []
    messages << Poseidon::MessageToSend.new(@topic, value)
    @producer.send_messages(messages)
  end
end
