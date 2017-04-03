class RenameWalletIdToWalletAddress < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :wallet_id, :wallet_address
  end
end
