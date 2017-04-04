require "rails_helper"

RSpec.describe User, type: :model do

  subject { build(:user) }

  before do
    expect(subject).to be_valid
  end

  context "validations" do
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(  :email) }
    it { should validate_length_of(    :email).is_at_most(255) }

    it { should validate_length_of(:password).is_at_most(255) }

    it { should validate_length_of(:reset_password_token).is_at_most(255) }

    it { should validate_uniqueness_of(:wallet_address) }
    it { should validate_length_of(    :wallet_address).is_at_most(255) }

    it { should validate_presence_of(:wallet_btc) }

    it { should validate_presence_of(:wallet_usd) }
  end

  context "before_save" do

    describe "#generate_wallet_address" do

      context "missing address" do
        it "generates an address" do
          fail("HERE -- Needs Coinbase interaction to generate a wallet address")
          expect(subject.wallet_address).to eq(nil)

          subject.save!

          expect(subject.wallet_address).to eq('asdf')
        end
      end
    end
  end

end
