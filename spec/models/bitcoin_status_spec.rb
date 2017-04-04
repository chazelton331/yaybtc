require "rails_helper"

RSpec.describe BitcoinStatus, type: :model do

  let(:bitcoin_status) { BitcoinStatus.new }

  it "saves a new record" do
    VCR.use_cassette :winkdex_price do
      expect {
        bitcoin_status.save_current_values
      }.to change { Bitcoin.count }.by(1)
    end
  end
end
