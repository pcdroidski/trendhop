class UserFeed < ActiveRecord::Base
  belongs_to :user
  belongs_to :feed
  #belongs_to :group

  scope :politics, :conditions => {:feed_group_id => 1}
  scope :sports, :conditions => {:feed_group_id => 2}
  scope :technology, :conditions => {:feed_group_id => 3}
  scope :world, :conditions => {:feed_group_id => 5}
  scope :health, :conditions => {:feed_group_id => 8}
  scope :travel, :conditions => {:feed_group_id => 9}
  scope :business, :conditions => {:feed_group_id => 10}
  scope :finance, :conditions => {:feed_group_id => 11}
  scope :us, :conditions => {:feed_group_id => 12}
  scope :science, :conditions => {:feed_group_id => 4}
  scope :art, :conditions => {:feed_group_id => 6}

end
