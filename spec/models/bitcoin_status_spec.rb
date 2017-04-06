require "rails_helper"

RSpec.describe BitcoinStatus, type: :model do

  context "validations" do
    it { should validate_presence_of(:price) }
  end

  it "saves a new record" do
    VCR.use_cassette :winkdex_price do
      expect { BitcoinStatus.save_current_values }.to change { BitcoinStatus.count }.by(1)
    end
  end
end
