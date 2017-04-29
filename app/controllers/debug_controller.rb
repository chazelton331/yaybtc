class DebugController < ApplicationController

  def index
    @sentiment_statuses = SentimentStatus.order('created_at DESC').limit(25)
    @bitcoin_statuses   =   BitcoinStatus.order('created_at DESC').limit(25)
    @users              =            User.order('created_at DESC').limit(10)
  end

end
