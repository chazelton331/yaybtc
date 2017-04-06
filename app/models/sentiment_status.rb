# == Schema Information
#
# Table name: sentiment_statuses
#
#  id         :integer          not null, primary key
#  score      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class SentimentStatus < ApplicationRecord

  validates :score, presence: true

  def self.save_current_values
    reddit_sentiment_score = RedditQuery.new.fetch_newest_posts
    total_score            = [ reddit_sentiment_score ].inject(:+)

    create(score: total_score)
  end
end
