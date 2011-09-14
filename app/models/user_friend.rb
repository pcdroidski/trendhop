class UserFriend < ActiveRecord::Base

  belongs_to :user
  belongs_to :friend, :class_name => "User", :foreign_key => :friend_id
  belongs_to :group
 # belongs_to :user, :through => :friend_id

end
