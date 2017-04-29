require 'rails_helper'

RSpec.describe AccountsController, type: :controller do

  before(:each) do
    VCR.insert_cassette(:coinbase_account_creation, allow_playback_repeats: true)
  end

  after(:each) do
    VCR.eject_cassette
  end

  before do
    @user = User.create!(name: "someuser")
  end

  describe "POST toggle" do

    context "signed out" do

      it "requires a logged in user" do
        post :toggle
        expect(response.status).to eq(401)
      end

      it "returns errors" do
        post :toggle
        expect(response.body).to eq("HTTP Basic: Access denied.\n")
      end
    end

    context "signed in" do
      before do
        request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials('someuser', 'password')
      end

      it "returns a 201 status code" do
        post :toggle
        expect(response.status).to eq(201)
      end

      it "returns a message" do
        post :toggle
        expect(JSON.parse(response.body)).to eq({ "enabled" => @user.reload.auto_buy_sell_enabled? })
      end

      it "toggles the user#auto_buy_sell_enabled value" do
        expect(@user.auto_buy_sell_enabled?).to eq(false)

        post :toggle; expect(@user.reload.auto_buy_sell_enabled?).to eq(true )
        post :toggle; expect(@user.reload.auto_buy_sell_enabled?).to eq(false)
      end
    end
  end
end
