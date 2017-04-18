class AccountsController < ApplicationController

  def toggle
    if @user = current_user
      @user.auto_buy_sell_enabled = !@user.auto_buy_sell_enabled
      @user.save

      @status = 201

      render json: { enabled: @user.auto_buy_sell_enabled }, status: 201
    else
      render json: { errors: "Not found" }, status: 401
    end
  end

end
