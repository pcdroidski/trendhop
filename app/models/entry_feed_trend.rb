class EntryFeedTrend < ActiveRecord::Base

  belongs_to :entry_feed
  belongs_to :trend

  private

  def self.create_trends(db_entry, entry)
    entry.categories.each do |trend|
      get_trend = Trend.entry_feed_trend(trend)
      create!(
       :entry_feed_id       => db_entry.id,
       :trend_id      => get_trend.id
       )
       entry.categories.each do |trend_2|
         get_trend2 = Trend.entry_feed_trend(trend_2)
         if get_trend != get_trend2
           TrendHop.create_hops(get_trend, get_trend2)
         end
       end
    end
  end

  define_index do
    indexes entry_feed
    indexes trend.name

  end


end
