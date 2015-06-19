require 'poseidon'
require 'config'

class Producer
  def initialize(topic, id)

    @producer = Poseidon::Producer.new ["#{Config::KAFKA_HOST}:#{Config::KAFKA_PORT}"], id, partitioner: partitioner
    @topic = topic
    @id = id
  end

  def send(value)
    puts "Producer-ID #{@id}: Sending #{value.slice(0, 8)}... to topic #{@topic}"
    messages = []
    messages << Poseidon::MessageToSend.new(@topic, value, @id)
    @producer.send_messages(messages)
  end

  def partitioner
    Proc.new { |key, partition_count| 1 }
  end
end
