require 'poseidon'
require 'config'

class Producer
  def initialize(topic, id)
    @producer = Poseidon::Producer.new ["#{Config::KAFKA_HOST}:#{Config::KAFKA_PORT}"], id
    @topic = topic
    @id = id
  end

  def send(value)
    messages = []
    messages << Poseidon::MessageToSend.new(@topic, value, @id)
    @producer.send_messages(messages)
  end
end
