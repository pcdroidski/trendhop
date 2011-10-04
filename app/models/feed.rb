class Feed < ActiveRecord::Base

  has_many :entry_feeds, :dependent => :destroy

end
