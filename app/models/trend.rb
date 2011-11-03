class Trend < ActiveRecord::Base

  has_many :post_trends
  has_many :post_contents, :through => :post_trends

  belongs_to :user_following_trends

  has_many :entry_feed_trends

  has_many :posts, :through => :post_contents

  has_many :entry_feed_trends
  has_many :entry_feeds, :through => :entry_feed_trends

  has_many :user_trends
  has_many :users, :through => :user_trends

  has_many :trend_hops
  has_many :trends, :through => :trend_hops

  scope :set_range, lambda {|field| where (["trends.updated_at >= ?", eval("Time.now-1.#{field}") ])}  #field = [day, week, month, year]
  scope :set_men, joins(:users).where(["users.sex = 0"])
  scope :set_women, joins(:users).where(["users.sex = 1"])

  # scope :user_follow, lambda {|user| {:joins => :user_following_trends, :conditions => ["user_following_trends.user_id == #{user}"] }}

# Trend filtering #
  #Ages: 13 & younger, 13-15, 16-18, 19-21, 21-24, 25-29, 30-35, 36-40,
  def age_set(age)
    age = self.where(:user)
  end

  def list
    self.trends.map(&:name)
  end

  define_index do
    indexes :name
  end


  private

  def self.entry_feed_trend(trend)
    trend_find = Trend.where(:name => trend).first
    if trend_find.blank?
      trend_get = trend.delete("!").delete("@").delete("#").delete("*").delete("(").delete(")").delete("?").delete(".").delete(",").delete("<").delete(">").delete("/").delete('\\').delete("-")
      create!(
        :name         => trend_get,
        :trend_count  => 0,
        :like_count   => 0
        )
      trend_find = Trend.where(:name => trend_get).first
    end
    return trend_find
  end

end
