class Group < ActiveRecord::Base
  has_many :user_friends
  belongs_to :user

  def user_groups(user)
    Group.where(:user_id => user.id)
  end

end
