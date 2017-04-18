require 'rails_helper'

RSpec.describe RedditQuery, type: :model do

  describe "#fetch_sentiment_score" do
    it "sets @sentiment_score" do
      VCR.use_cassette(:r_bitcoin_posts) do
        expect(RedditQuery.new.fetch_sentiment_score).to eq(0.47280334728033474)
      end
    end
  end
end
