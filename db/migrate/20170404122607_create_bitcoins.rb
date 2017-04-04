class CreateBitcoins < ActiveRecord::Migration[5.0]
  def change
    create_table :bitcoins do |t|
      t.float   :price
      t.integer :volume
      t.timestamps
    end
  end
end
