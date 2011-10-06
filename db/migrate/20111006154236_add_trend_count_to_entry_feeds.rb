class AddTrendCountToEntryFeeds < ActiveRecord::Migration
  def change
     add_column :entry_feeds, :trend_count, :integer
     add_column :entry_feeds, :tags, :string
  end
end
