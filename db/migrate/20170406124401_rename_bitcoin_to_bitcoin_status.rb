class RenameBitcoinToBitcoinStatus < ActiveRecord::Migration[5.0]
  def change
    rename_table :bitcoins, :bitcoin_statuses
  end
end
