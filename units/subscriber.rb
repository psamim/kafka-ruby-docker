require 'kafka/consumer'
require 'config'
require 'json'

class Subscriber
  def initialize(id)
    begin
      @id = id
      connect
      puts "Subscriber with ID #{id} connected."
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
      r = JSON.parse(m.value)['report']
      puts "*RESULT*  Subscriber ID: #{@id}"
      puts "*RESULT*  Weather on #{r['terrestrial_date']}:"
      puts "*RESULT*  Minimum Temprature: #{r['min_temp']}"
      puts "*RESULT*  Maximum Temprature: #{r['max_temp']}"
      puts "*RESULT*  Pressure: #{r['pressure']}"
      puts "*RESULT*  Sunrise: #{r['sunrise']}"
      puts "*RESULT*  Sunrise: #{r['sunset']}"
    end
  end
end
