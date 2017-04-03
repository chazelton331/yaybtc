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
            :wallet_id, length: { maximum: 255 }

  validates :email,
            :wallet_id, uniqueness: true

  validates :email, presence: true

end
