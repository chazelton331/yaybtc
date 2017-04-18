require 'rails_helper'

RSpec.describe AccountsController, type: :controller do

  before do
    @user = User.create!(email: "cliff@example.com", password: "possward")
  end

  describe "POST toggle" do

    context "signed out" do
      before do
        sign_out @user
      end

      it "requires a logged in user" do
        post :toggle
        expect(response.status).to eq(401)
      end

      it "returns errors" do
        post :toggle
        expect(JSON.parse(response.body)).to eq({ "error" => "Not found" })
      end
    end

    context "signed in" do
      before do
        sign_in @user
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
