class RedditQuery

  BASE_URL       = "https://api.reddit.com"
  SUBREDDIT      = "/r/bitcoin"
  HOT_ENDPOINT   = "hot"

  attr_reader :sentiment_score

  def initialize
    @running_total_score = 0
    @number_of_posts     = 0
  end
  
  def fetch_sentiment_score
    begin
      json_body = HTTParty.get("#{BASE_URL}/#{SUBREDDIT}/#{HOT_ENDPOINT}", headers: { "User-Agent" => "yaybtc-app" }).body
      hash_body = JSON.parse(json_body)

      hash_body["data"]["children"].each { |child| process_post(child) }

      unless Rails.env.test?
        STDERR.puts "processed #{@number_of_posts} posts with a running total of #{@running_total_score}"
      end

      @running_total_score.to_f/@number_of_posts
    rescue => e
      Rails.logger.error("FAILED to process reddit bitcoin posts because #{e.message}")
      e.backtrace.each { |line| Rails.logger.error(line) }
    end
  end

  private

  def process_post(child)
    begin
      post_id   = child["data"]["id"]
      json_body = HTTParty.get("#{BASE_URL}/#{SUBREDDIT}/comments/#{post_id}", headers: { "User-Agent" => "yaybtc-app" }).body
      hash_body = JSON.parse(json_body)

      hash_body.each do |entry|
        entry["data"]["children"].each do |child_node|
          if child_node["data"]["selftext"].present?
            @number_of_posts     += 1
            @running_total_score += SentimentScorer.new.process(child_node["data"]["selftext"])[:score]
          elsif child_node["data"]["body"].present?
            @number_of_posts     += 1
            @running_total_score += SentimentScorer.new.process(child_node["data"]["body"])[:score]
          end
        end
      end
    rescue => e
      Rails.logger.error("FAILED to process post id #{post_id} because #{e.message}")
      e.backtrace.each { |line| Rails.logger.error(line) }
    end
  end

end
