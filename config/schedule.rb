# http://github.com/javan/whenever

require File.expand_path(File.dirname(__FILE__) + "/../config/environment")

set :output, {
 error:    "log/error.log",
 standard: "log/cron.log"
}

every 1.minute do
  runner 'BitcoinStatus.new.save_current_values'
end
