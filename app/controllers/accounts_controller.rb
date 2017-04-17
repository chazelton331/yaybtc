class AccountsController < ApplicationController

  def toggle
    if @user = current_user
      @user.auto_buy_sell_enabled = !@user.auto_buy_sell_enabled
      @user.save

      redirect_to root_path, status: 201
    else
      redirect_to root_path, status: 401
    end

  end

end
