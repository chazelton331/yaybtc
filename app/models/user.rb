# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  auto_buy_sell_enabled  :boolean          default(FALSE), not null
#  coinbase_account_id    :string
#  last_address           :string
#  last_address_was_used  :boolean          default(FALSE), not null
#

require 'coinbase/wallet'

class User < ApplicationRecord

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  validates :email,
            :password,
            :reset_password_token,
            :last_address,
            :coinbase_account_id, length: { maximum: 255 }

  validates :email,
            :last_address,
            :coinbase_account_id, uniqueness: true

  validates :email, presence: true

  before_save :create_coinbase_account, if: Proc.new { |model| model.coinbase_account_id.blank? }

  def wallet_btc
    coinbase_account.balance.amount
  end

  def wallet_usd
    coinbase_account.native_balance.amount
  end

  def buy_bitcoin(percent=100.0)
    current_btc_value = wallet_btc
    # perform a buy with 'percent' of your total usd value that you have in your wallet
    # coinbase_account.buy(xyz)
  end

  def sell_bitcoin(percent=100.0)
    current_btc_value = wallet_btc
    # perform a sell with 'percent' of your total bitcoin value that's invested
    # coinbase_account.sell(xyz)
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
    account = coinbase_client.create_account(name: Time.now.to_i.to_s)
    self.coinbase_account_id = account.id
  end
end
