class AddCoinbaseAccountIdToUserModelAndRenameOtherFields < ActiveRecord::Migration[5.0]
  def change
    add_column    :users, :coinbase_account_id,   :string
    add_column    :users, :last_address,          :string
    add_column    :users, :last_address_was_used, :boolean, default: false, null: false

    remove_column :users, :wallet_address
    remove_column :users, :wallet_usd
    remove_column :users, :wallet_btc
    remove_column :users, :address_id
  end
end
