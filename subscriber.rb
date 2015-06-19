$:.unshift File.join(File.dirname(__FILE__))
$stdout.sync = true

require 'units/subscriber'

subscriber = Subscriber.new ARGV[0]
subscriber.listen
