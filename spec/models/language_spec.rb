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

  it "returns a WORD_BOUNDARY_REGEX" do
    expect(Language::WORD_BOUNDARY_REGEX).to eq(/\b/)
  end

  it "returns PUNCTUATION_MARKS" do
    expect(Language::PUNCTUATION_MARKS.first).to eq("!")
  end

end
