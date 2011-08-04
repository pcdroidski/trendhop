class TrendHop < ActiveRecord::Base
  belongs_to :trend
  has_many :trends, :foreign_key => :related_trend_id

end
