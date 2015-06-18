$:.unshift File.join(File.dirname(__FILE__))
$stdout.sync = true

require 'units/processor'

processor = Processor.new
processor.listen
