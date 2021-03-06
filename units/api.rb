require 'kafka/producer'

class Api < Sinatra::Base
  enable :logging
  API_ID = 'api'

    def initialize(app = nil, params = {})
      super(app)
      @producer = Producer.new Config::REQUESTS_QUEUE, API_ID
    end

  get '/' do
    'Hello from docker!'
  end

  get '/sol/:sol' do
    logger.info "Sending sol #{params['sol']} into the queue."
    @producer.send params['sol']
    "Request was put into queue for sol #{params['sol']}!"
  end
end
