require 'rails_helper'

RSpec.describe ProcessedPost, type: :model do

  context "validations" do
    it { should validate_presence_of(:post_id) }
    it { should validate_length_of(  :post_id).is_at_most(255) }

    it { should validate_presence_of(:source) }
    it { should validate_length_of(  :source).is_at_most(255) }

    describe "#post_id" do
      it "is unique in the scope of source" do
        post1 = ProcessedPost.new(source: 'reddit', post_id: '1')
        post2 = ProcessedPost.new(source: 'blargh', post_id: '1')
        post3 = ProcessedPost.new(source: 'reddit', post_id: '1')

        expect(post1.save).to   eq(true )
        expect(post2.save).to   eq(true )
        expect(post3.valid?).to eq(false)
      end
    end
  end

end
