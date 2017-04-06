require "net/http"
require "uri"

class RedditQuery

  BASE_URL       = "https://api.reddit.com/r"
  SUBREDDIT      = "bitcoin"
  NEW_ENDPOINT   = "new"
  
  def fetch_newest_posts
    uri            = URI.parse("#{BASE_URL}/#{SUBREDDIT}/#{NEW_ENDPOINT}")
    response       = Net::HTTP.get_response(uri)
    hash_response  = JSON.parse(response.body)

    # get all ids/created times/selftext
    # figure out which ones we've saved
    # if it's older than a certain time, reprocess comments
    # get overall sentiment score for that post + it's comments
    # combine all existing posts
    # return total score
    # hash_response["data"]["children"].each { |child| process_post(child) }

    100
  end

  private

  def process_post(child)
    # store post by data.id
    # if post already exists, refresh comments every hour (or something)
    #
    #puts child["data"]["id"         ]
    #puts child["data"]["created_utc"]
    #puts child["data"]["selftext"   ]
    #puts '-'
  end

end
