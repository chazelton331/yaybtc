require "rails_helper"

RSpec.describe Language, type: :model do

  it "returns a list of NEGATIVE_SENTIMENT_WORDS" do
    expect(Language::NEGATIVE_SENTIMENT_WORDS.first).to eq("2-faced")
  end

  it "returns a list of POSITIVE_SENTIMENT_WORDS" do
    expect(Language::POSITIVE_SENTIMENT_WORDS.first).to eq("a+")
  end

  it "returns a list of STOP_WORDS" do
    expect(Language::STOP_WORDS.first).to eq("a")
  end

end
