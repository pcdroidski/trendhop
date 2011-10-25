class CreateEntryFeedTrends < ActiveRecord::Migration
  def change
    create_table :entry_feed_trends do |t|
      t.integer :entry_feed_id
      t.integer :trend_id

      t.timestamps
    end
  end
end
