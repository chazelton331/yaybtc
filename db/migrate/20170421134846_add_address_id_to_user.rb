class AddAddressIdToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :address_id, :string
  end
end
