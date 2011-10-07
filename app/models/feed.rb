class Feed < ActiveRecord::Base

  has_many :entry_feeds, :dependent => :destroy
  has_many :user_feeds

  belongs_to :feed_category


end
