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

  after_create :invoke_buy_sell_analyzer

  def self.save_current_values
    reddit_sentiment_score = RedditQuery.new.fetch_sentiment_score
    total_score            = [ reddit_sentiment_score ].inject(:+)

    create(score: total_score)
  end

  private

  def invoke_buy_sell_analyzer
    BuySellAnalyzer.new.process
  end
end
