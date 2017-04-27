class DebugController < ApplicationController

   http_basic_authenticate_with name: ENV['BASIC_NAME'], password: ENV['BASIC_PASSWORD']

  def index
    @sentiment_statuses = SentimentStatus.order('created_at DESC').limit(25)
    @bitcoin_statuses   =   BitcoinStatus.order('created_at DESC').limit(25)
    @users              =            User.order('created_at DESC').limit(10)
  end

end
