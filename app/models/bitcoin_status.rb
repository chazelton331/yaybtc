# == Schema Information
#
# Table name: bitcoin_statuses
#
#  id         :integer          not null, primary key
#  price      :float
#  volume     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class BitcoinStatus < ApplicationRecord

  validates :price, presence: true

  def self.save_current_values
    price = WinkdexQuery.new.fetch_current_price

    create(price: price)
  end
end
