class PostTrend < ActiveRecord::Base

  belongs_to :post_content

  belongs_to :trend


end
