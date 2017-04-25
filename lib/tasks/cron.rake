namespace :cron do

  desc "Run bitcoin status" 
  task :bitcoin_status do
    BitcoinStatus.save_current_values
  end

  desc "Run sentiment status" 
  task :sentiment_status do
    SentimentStatus.save_current_values
  end
end
