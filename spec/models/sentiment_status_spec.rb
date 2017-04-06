# == Schema Information
#
# Table name: sentiment_statuses
#
#  id         :integer          not null, primary key
#  score      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe SentimentStatus, type: :model do

  context "validations" do
    it { should validate_presence_of(:score) }
  end

  it "saves a new record" do
    VCR.use_cassette(:r_bitcoin_newest) do
      expect { SentimentStatus.save_current_values }.to change { SentimentStatus.count }.by(1)
    end
  end
end
