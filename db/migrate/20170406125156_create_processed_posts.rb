class CreateProcessedPosts < ActiveRecord::Migration[5.0]
  def change
    create_table :processed_posts do |t|
      t.string :post_id
      t.string :source

      t.timestamps
    end
  end
end
