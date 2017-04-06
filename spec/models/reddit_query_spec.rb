require 'rails_helper'

RSpec.describe RedditQuery, type: :model do

  it "blah" do
    VCR.use_cassette(:r_bitcoin_newest) do
      RedditQuery.new.fetch_newest_posts
    end
  end
end
