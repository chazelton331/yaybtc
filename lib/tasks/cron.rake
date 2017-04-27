namespace :cron do

  desc "Run bitcoin status" 
  task :bitcoin_status do
    BitcoinStatus.save_current_values
  end

  desc "Run sentiment status" 
  task :sentiment_status do
    SentimentStatus.save_current_values
  end

  desc "Run buy/sell analyzer" 
  task :buy_sell_analyzer do
    BuySellAnalyzer.new.process
  end
end
