class CreateSentimentStatuses < ActiveRecord::Migration[5.0]
  def change
    create_table :sentiment_statuses do |t|
      t.integer :score
      t.timestamps
    end
  end
end
