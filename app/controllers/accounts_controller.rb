class AccountsController < ApplicationController

  def toggle
    if @current_user
      @current_user.auto_buy_sell_enabled = !@current_user.auto_buy_sell_enabled
      @current_user.save

      render json: { enabled: @current_user.auto_buy_sell_enabled }, status: 201
    else
      render json: { error: "Not found" }, status: 401
    end
  end

end
