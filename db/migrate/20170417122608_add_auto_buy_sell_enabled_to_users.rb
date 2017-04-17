class AddAutoBuySellEnabledToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :auto_buy_sell_enabled, :boolean, default: false, null: false
  end
end
