class BitcoinStatus

  def initialize
    @winkdex_query = WinkdexQuery.new
  end

  def save_current_values
    price = @winkdex_query.fetch_current_price

    Bitcoin.create(price: price)
  end

end
