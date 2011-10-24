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
    end
  end

end
