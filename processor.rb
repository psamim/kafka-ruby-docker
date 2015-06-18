$:.unshift File.join(File.dirname(__FILE__))
$stdout.sync = true
require 'kafka/consumer'
require 'config'

class Processor
  def initialize
    begin
      connect
      puts 'Processor connected'
    rescue Exception => e
      puts e.message
      puts "Trying in 5 seconds"
      sleep 5
    end
  end

  def connect
    @consumer = Consumer.new Config::REQUESTS_QUEUE
  end

  def listen
    @consumer.listen do |m|
      puts "Topic: #{m.topic}"
      puts "Value #{m.value}"
      puts "Key: #{m.key}"
      puts "Offset: #{m.offset}"
    end
  end
end

processor = Processor.new
processor.listen
