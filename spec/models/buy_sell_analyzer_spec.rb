require 'rails_helper'

RSpec.describe BuySellAnalyzer, type: :model do

  let(:buy_sell_analyzer) { BuySellAnalyzer.new }

  context "constants" do
    it "defines buy" do
      expect(BuySellAnalyzer::BUY).to eq(:buy)
    end

    it "defines sell" do
      expect(BuySellAnalyzer::SELL).to eq(:sell)
    end

    it "defines hold" do
      expect(BuySellAnalyzer::HOLD).to eq(:hold)
    end

    it "defines ratings" do
      expect(BuySellAnalyzer::RATINGS).to eq([
        BuySellAnalyzer::BUY,
        BuySellAnalyzer::SELL,
        BuySellAnalyzer::HOLD,
      ])
    end
  end

  describe "#process" do
    it "returns a buy/sell/hold rating" do
      expect(buy_sell_analyzer.process[:rating]).to eq(BuySellAnalyzer::BUY)
    end

    it "returns a confidence score" do
      expect(buy_sell_analyzer.process[:confidence]).to eq(0.75)
    end
  end
end
