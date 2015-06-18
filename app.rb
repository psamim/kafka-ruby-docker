require 'producer'

class App < Sinatra::Base
  enable :logging

  def initialize(app = nil, params = {})
    super(app)
    @producer = Producer.new Config::REQUESTS_QUEUE
  end

  get '/' do
    'Hello from docker!'
  end

  get '/sol/:sol' do
    @producer.send params['sol']
    "Request was put into queue for sol #{params['sol']}!"
  end
end
