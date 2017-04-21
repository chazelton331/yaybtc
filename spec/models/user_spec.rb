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
#  auto_buy_sell_enabled  :boolean          default(FALSE), not null
#  coinbase_account_id    :string
#  last_address           :string
#  last_address_was_used  :boolean          default(FALSE), not null
#

require "rails_helper"

RSpec.describe User, type: :model do

  before(:each) do
    VCR.insert_cassette(:coinbase_account_creation, allow_playback_repeats: true)
  end

  after(:each) do
    VCR.eject_cassette
  end

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

    it { should validate_uniqueness_of(:coinbase_account_id) }
    it { should validate_length_of(    :coinbase_account_id).is_at_most(255) }

    it { should validate_uniqueness_of(:last_address) }
    it { should validate_length_of(    :last_address).is_at_most(255) }
  end

  context "before_save" do

    describe "#create_coinbase_account" do

      context "missing #coinbase_account_id" do
        it "generates an address" do
          expect(subject.coinbase_account_id).to eq(nil)

          subject.save!

          expect(subject.coinbase_account_id).to eq("19cc04b9-6c06-5575-83ca-f94937de895e")
        end
      end
    end
  end

end
