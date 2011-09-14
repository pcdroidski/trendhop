class Group < ActiveRecord::Base
  has_many :user_friends
end
