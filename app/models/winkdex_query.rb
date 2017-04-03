require "net/http"
require "uri"

class WinkdexQuery

  attr_reader :price

  BASE_URL       = "https://winkdex.com/api"
  VERSION        = "v0"
  PRICE_ENDPOINT = "price"
  
  def fetch_current_price
    uri            = URI.parse("#{BASE_URL}/#{VERSION}/#{PRICE_ENDPOINT}")
    response       = Net::HTTP.get_response(uri)
    hash_response  = JSON.parse(response.body)

    @price = hash_response["price"]/100.0
  end

end
