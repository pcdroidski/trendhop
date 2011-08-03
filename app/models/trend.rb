class Trend < ActiveRecord::Base
  
  belongs_to :blog
  belongs_to :user
  
  has_many :blogs
  has_many :users
end
