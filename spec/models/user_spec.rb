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

end
