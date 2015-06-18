require 'poseidon'
require 'config'

class Consumer
  def initialize(topic)
    @consumer = Poseidon::PartitionConsumer.new(Config::CONS_ID, Config::SERVER, Config::PORT, topic, 0, :earliest_offset)
    @topic = topic
  end

  def listen
    loop do
      begin
        messages = @consumer.fetch
        messages.each do |m|
          yield(m)
        end
      rescue Exception => e
        puts e.message
        # puts e.backtrace.inspect
        puts "Trying in 5 seconds"
        sleep 5
      end
    end
  end
end
