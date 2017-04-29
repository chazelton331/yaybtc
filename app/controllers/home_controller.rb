class HomeController < ApplicationController

  def index
    @sentiment_statuses = SentimentStatus.order('created_at DESC').limit(25)
    @bitcoin_statuses   =   BitcoinStatus.order('created_at DESC').limit(25)
  end

end
