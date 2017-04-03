class AddWalletIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :wallet_id, :string
  end
end
