class ProcessedPost < ApplicationRecord
  validates :post_id, uniqueness: { scope: :source }

  validates :post_id,
            :source, presence: true, length: { maximum: 255 }
end
