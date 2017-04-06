# http://github.com/javan/whenever

require File.expand_path(File.dirname(__FILE__) + "/../config/environment")

set :output, {
 error:    "log/error.log",
 standard: "log/cron.log"
}

every 1.minute do
  runner 'BitcoinStatus.save_current_values'
end

every 1.hour do
  runner 'SentimentStatus.save_current_values'
end
