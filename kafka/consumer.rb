require 'poseidon'
require 'config'

class Consumer
  def initialize(topic, id)
    @consumer = Poseidon::PartitionConsumer.new(id, Config::KAFKA_HOST, Config::KAFKA_PORT, topic, 1, :earliest_offset)
    @topic = topic
    @id = id
  end

  def listen
    loop do
      begin
        loop do
          messages = @consumer.fetch
          messages.each do |m|
            puts "ConsumerID #{@id}: Fetched '#{m.value.slice(0,8)}...' at #{m.offset}"
            yield(m)
          end
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
