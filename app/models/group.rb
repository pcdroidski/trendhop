class Group < ActiveRecord::Base
  has_many :user_friends
  belongs_to :user
end
