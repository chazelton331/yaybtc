require "rails_helper"

RSpec.describe SentimentScorer, type: :model do

  let(:sentiment_scorer) { SentimentScorer.new }
  let(:negative_text   ) { "I'm going to abort this stupid train ride into the abyss of anguish;ASUNDER bad,betrayal,bitch" }
  let(:positive_text   ) { "I am in love with bitcoin it is so great that it makes me happy and the price is going up and we're all gonna be rich" }

  it "scores a string of negative text" do
    expect(sentiment_scorer.process(negative_text)).to eq(score: -8)
  end

  it "scores a string of positive text" do
    expect(sentiment_scorer.process(positive_text)).to eq(score: 4)
  end

end
