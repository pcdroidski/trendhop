class AddEntryFeedIdToPostsAlongwithLikes < ActiveRecord::Migration
  def change
    add_column :posts, :entry_feed_id, :integer
    add_column :entry_feeds, :like, :integer
  end
end
