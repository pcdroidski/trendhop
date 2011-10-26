module TrendsHelper

  def list_trend_categories(trends)
    categories = []
    trends.each do |trend|
      categories <<" " + trend.trend_category_id unless trend.trend_category_id.blank?
    end
    categories
  end

  def like_counts(trends)
    count = 0
    trends.each do |trend|
      count = count + trend.like_count unless trend.like_count.blank?
    end
    count
  end

  def trend_counts(trends)
    count = 0
    trends.each do |trend|
      count = count + trend.trend_count unless trend.trend_count.blank?
    end
    count
  end

end
