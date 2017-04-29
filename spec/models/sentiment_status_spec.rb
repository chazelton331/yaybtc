# == Schema Information
#
# Table name: sentiment_statuses
#
#  id         :integer          not null, primary key
#  score      :float            default(0.0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe SentimentStatus, type: :model do

  context "validations" do
    it { should validate_presence_of(:score) }
  end

  it "saves a new record" do
    VCR.use_cassette(:r_bitcoin_newest) do
      expect { SentimentStatus.save_current_values }.to change { SentimentStatus.count }.by(1)
    end
  end

  it "saves a fractional score" do
    VCR.use_cassette(:r_bitcoin_newest) do
      SentimentStatus.save_current_values
      expect(SentimentStatus.last.score).to eq(0.48728813559322)
    end
  end

  it "saves a negative score" do
    expect(RedditQuery).to receive(:new).and_return(double(fetch_sentiment_score: -41))

    SentimentStatus.save_current_values
    expect(SentimentStatus.last.score).to eq(-41.0)
  end
end
