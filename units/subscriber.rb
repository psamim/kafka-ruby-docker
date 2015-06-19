require 'kafka/consumer'
require 'config'

class Subscriber
  def initialize(id)
    begin
      connect
      puts "Subscriber with ID #{id} connected."
      @id = id
    rescue Exception => e
      puts e.message
      puts "Trying in 5 seconds"
      sleep 5
    end
  end

  def connect
    @consumer = Consumer.new Config::SOL_TOPIC, "subscriber-#{@id}"
  end

  def listen
    @consumer.listen do |m|
      puts "New value #{m.value} from topic #{m.topic}."
    end
  end
end
