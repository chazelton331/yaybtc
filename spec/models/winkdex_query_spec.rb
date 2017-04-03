require "rails_helper"

RSpec.describe WinkdexQuery, type: :model do

  let(:winkdex_query) { WinkdexQuery.new }

  it "sets the price" do
    VCR.use_cassette :winkdex_price do
      winkdex_query.fetch_current_price
      expect(winkdex_query.price).to eq(1117.08)
    end
  end
end
