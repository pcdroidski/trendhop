class CreateEntryFeeds < ActiveRecord::Migration
  def change
    create_table :entry_feeds do |t|
      t.integer :feed_id
      t.string :title
      t.text :summary
      t.text :content
      t.string :url
      t.datetime :published_at
      t.string :guid

      t.timestamps
    end
  end
end
