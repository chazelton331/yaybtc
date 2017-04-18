# == Schema Information
#
# Table name: sentiment_statuses
#
#  id         :integer          not null, primary key
#  score      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe SentimentStatus, type: :model do

  context "validations" do
    it { should validate_presence_of(:score) }
  end

  context "callbacks" do
    describe "#after_create" do
      it "invokes the BuySellAnalyzer" do
        buy_sell_analyzer_double = double()
        expect(buy_sell_analyzer_double).to receive(:process)
        expect(BuySellAnalyzer).to receive(:new).and_return(buy_sell_analyzer_double)
        SentimentStatus.create(score: 6)
      end
    end
  end

  it "saves a new record" do
    VCR.use_cassette(:r_bitcoin_newest) do
      expect { SentimentStatus.save_current_values }.to change { SentimentStatus.count }.by(1)
    end
  end
end
