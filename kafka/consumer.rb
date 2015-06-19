require 'poseidon_cluster'
require 'config'

class Consumer
  def initialize(topic, id)
    @consumer = Poseidon::ConsumerGroup.new(
      id, # Group name
      ["#{Config::KAFKA_HOST}:#{Config::KAFKA_PORT}"],
      ["#{Config::ZK_HOST}:#{Config::ZK_PORT}"],
      topic) # Topic name
    @topic = topic
    @id = id
  end

  def listen
    loop do
      begin
        @consumer.fetch_loop do |partition, bulk|
          bulk.each do |m|
            puts "ConsumerID #{@id}: Fetched '#{m.value}' at #{m.offset} from #{partition}"
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
