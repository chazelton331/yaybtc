class SentimentStatus < ApplicationRecord

  validates :score, presence: true

end
