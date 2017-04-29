# == Schema Information
#
# Table name: users
#
#  id                    :integer          not null, primary key
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  auto_buy_sell_enabled :boolean          default(FALSE), not null
#  coinbase_account_id   :string
#  last_address          :string
#  last_address_was_used :boolean          default(FALSE), not null
#  name                  :string
#

require 'coinbase/wallet'

class User < ApplicationRecord

  validates :name,
            :last_address,
            :coinbase_account_id, length: { maximum: 255 }

  validates :name,
            :last_address,
            :coinbase_account_id, uniqueness: true

  before_save :create_coinbase_account, if: Proc.new { |model| model.coinbase_account_id.blank? }

  def wallet_btc
    coinbase_account.balance.amount
  end

  def wallet_usd
    coinbase_account.native_balance.amount
  end

  def buy_bitcoin
    payment_method = coinbase_client.payment_methods.first
    buy_price      = coinbase_client.buy_price(currency: 'USD')

    coinbase_account.buy(amount: (10.00/buy_price.amount).to_s, currency: "BTC", payment_method: payment_method.id)
  end

  def sell_bitcoin
    coinbase_account.sell(amount: wallet_btc, currency: "BTC", payment_method: payment_method.id)
  end

  def wallet_address
    if self.last_address.nil? || self.last_address_was_used?
      coinbase_account.create_address.address.tap do |address|
        self.last_address          = address
        self.last_address_was_used = false

        self.save(validate: false)
      end
    else
      most_recent_address
    end
  end

  private

  def most_recent_address
    coinbase_account.addresses.sort_by { |address| address.created_at }.reverse.first.try(:address)
  end

  def coinbase_account
    @memoized_coinbase_account ||= coinbase_client.account(self.coinbase_account_id)
  end

  def coinbase_client
    @memoized_coinbase_client ||= ::Coinbase::Wallet::Client.new(api_key: ENV['COINBASE_API_KEY'], api_secret: ENV['COINBASE_API_SECRET'])
  end

  def create_coinbase_account
    coinbase_client.create_account(name: Time.now.to_i.to_s).tap { |account| self.coinbase_account_id = account.id }
  end
end
