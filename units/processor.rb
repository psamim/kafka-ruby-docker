require 'open-uri'
require 'kafka/consumer'
require 'kafka/producer'
require 'config'
require 'helper/string'

class Processor
  def initialize
    begin
      connect
      puts 'Processor connected.'
    rescue Exception => e
      puts e.message
      puts "Trying in 5 seconds"
      sleep 5
    end
  end

  def connect
    @consumer = Consumer.new Config::REQUESTS_QUEUE
    @producer = Producer.new Config::SOL_TOPIC
  end

  def listen
    @consumer.listen do |m|
      puts "New value #{m.value} from topic #{m.topic}."
      if m.value.integer?
        file = open("http://marsweather.ingenology.com/v1/latest/?sol=#{m.value}")
        contents = file.read
        @producer.send contents
      else
        puts "Ignoring message #{m.value}, not an integer"
      end
    end
  end
end
