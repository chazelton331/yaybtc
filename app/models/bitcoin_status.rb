class BitcoinStatus < ApplicationRecord

  validates :price, presence: true

  def self.save_current_values
    price = WinkdexQuery.new.fetch_current_price

    create(price: price)
  end
end
