class Feed < ActiveRecord::Base

  has_many :entry_feeds, :dependent => :destroy
  has_many :user_feeds

  belongs_to :feed_category

  def update_all
    self.each do |f|
      EntryFeed.create_from_feed(f)
    end
  end
end
