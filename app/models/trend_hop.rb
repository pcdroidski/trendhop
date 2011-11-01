class TrendHop < ActiveRecord::Base

  belongs_to :trend, :foreign_key => :related_trend_id

  def self.create_hops(trend_1, trend_2)
    test_hop = TrendHop.where(:trend_id => trend_1.id, :related_trend_id => trend_2.id).first
    if test_hop.blank?
      create!(
        :trend_id             => trend_1.id,
        :related_trend_id     => trend_2.id
        )
    end
  end

end
