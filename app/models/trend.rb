class Trend < ActiveRecord::Base

  has_many :post_trends
  has_many :post_contents, :through => :post_trends

  has_many :posts, :through => :post_contents

  has_many :blog_trends
  has_many :blogs, :through => :blog_trends

  has_many :user_trends
  has_many :users, :through => :user_trends

  has_many :trend_hops
  has_many :trends, :through => :trend_hops

# Trend filtering #
  #Ages: 13 & younger, 13-15, 16-18, 19-21, 21-24, 25-29, 30-35, 36-40,
  def age_set(age)
    age = self.where(:user)
  end

  def list
    self.trends.map(&:name)
  end

end
