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
#  wallet_address         :string
#  wallet_usd             :float            default(0.0), not null
#  wallet_btc             :float            default(0.0), not null
#

class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  validates :email,
            :password,
            :reset_password_token,
            :wallet_address, length: { maximum: 255 }

  validates :email,
            :wallet_address, uniqueness: true

  validates :wallet_btc,
            :wallet_usd,
            :email, presence: true


  before_save :generate_wallet_address, if: Proc.new { |model| model.wallet_address.blank? }

  private

  def generate_wallet_address
    self.wallet_address = 'asdf'
  end
end
