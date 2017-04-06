# == Schema Information
#
# Table name: processed_posts
#
#  id         :integer          not null, primary key
#  post_id    :string
#  source     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ProcessedPost < ApplicationRecord
  validates :post_id, uniqueness: { scope: :source }

  validates :post_id,
            :source, presence: true, length: { maximum: 255 }
end
