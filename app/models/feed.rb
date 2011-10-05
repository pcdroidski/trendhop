class Feed < ActiveRecord::Base

  has_many :entry_feeds, :dependent => :destroy
  has_many :user_feeds
end
