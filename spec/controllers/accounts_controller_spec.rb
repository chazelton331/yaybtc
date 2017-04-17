require 'rails_helper'

RSpec.describe AccountsController, type: :controller do

  before do
    @user = User.create!(email: "cliff@example.com", password: "possward")
    sign_in @user
  end

  describe "POST toggle" do

    it "requires a logged in user" do
      sign_out @user

      post :toggle
      expect(response.status).to eq(401)
    end

    it "returns a 201 status code" do
      post :toggle
      expect(response.status).to eq(201)
    end

    it "toggles the user#auto_buy_sell_enabled value" do
      expect(@user.auto_buy_sell_enabled?).to eq(false)

      post :toggle; expect(@user.reload.auto_buy_sell_enabled?).to eq(true )
      post :toggle; expect(@user.reload.auto_buy_sell_enabled?).to eq(false)
    end
  end
end
