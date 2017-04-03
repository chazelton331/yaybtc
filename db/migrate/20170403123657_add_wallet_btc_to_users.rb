class AddWalletBtcToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :wallet_btc, :float, default: 0.0, null: false
  end
end
