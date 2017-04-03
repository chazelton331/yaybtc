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
