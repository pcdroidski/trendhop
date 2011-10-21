class UserFollowingTrend < ActiveRecord::Base
  belongs_to :user
  belongs_to :trend
end
