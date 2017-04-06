require 'rails_helper'

RSpec.describe SentimentStatus, type: :model do

  context "validations" do
    it { should validate_presence_of(:score) }
  end

end
