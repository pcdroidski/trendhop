class PostContent < ActiveRecord::Base

  has_many :posts

  has_many :post_trends
  has_many :trends, :through => :post_trends

end