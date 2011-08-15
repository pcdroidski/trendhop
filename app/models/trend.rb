class Trend < ActiveRecord::Base

  has_many :blog_trends
  has_many :blogs, :through => :blog_trends
  has_many :user_trends
  has_many :users, :through => :user_trends
  has_many :trend_hops
  has_many :trends, :through => :trend_hops

# Trend filtering #
  #Ages:
  def age_set(age)

  end

end
