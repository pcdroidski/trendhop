class TrendHop < ActiveRecord::Base
  belongs_to :trend, :foreign_key => :related_trend_id
  has_many :trends
end
