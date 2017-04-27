class ChangeSentimentStatusScoreToFloat < ActiveRecord::Migration[5.0]
  def change
    change_column :sentiment_statuses, :score, :float, default: 0.0, null: false
  end
end
