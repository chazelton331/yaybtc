# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  wallet_address         :string
#  wallet_usd             :float            default(0.0), not null
#  wallet_btc             :float            default(0.0), not null
#

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
