class BlogTrend < ActiveRecord::Base

  belongs_to :blog
  belongs_to :trend

end
