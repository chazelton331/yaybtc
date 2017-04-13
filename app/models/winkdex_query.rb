require "net/http"
require "uri"

class WinkdexQuery

  attr_reader :price

  BASE_URL       = "https://winkdex.com/api"
  VERSION        = "v0"
  PRICE_ENDPOINT = "price"
  
  def fetch_current_price
    json_body = HTTParty.get("#{BASE_URL}/#{VERSION}/#{PRICE_ENDPOINT}", headers: { "User-Agent" => "yaybtc-app" }).body
    hash_body = JSON.parse(json_body)

    @price = hash_body["price"]/100.0
  end

end
