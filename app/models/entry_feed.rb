class EntryFeed < ActiveRecord::Base

  belongs_to :feed

  has_many :posts

  has_many :entry_feed_trends, :dependent => :destroy
  has_many :trends, :through => :entry_feed_trends

  def self.create_from_feed(feed_info)
     feed = Feedzirra::Feed.fetch_and_parse(feed_info.url)
     add_entries(feed.entries, feed_info)
   end

   def self.update_from_feed(feed_info)
     feed = Feedzirra::Feed.fetch_and_parse(feed_info.url)
     feed = Feedzirra::Feed.update(feed)
     add_entries(feed.new_entries, feed_info) if feed.updated?
   end

   def self.update_from_feed_continuously(feed_info, delay_interval = 15.minutes)
     feed = Feedzirra::Feed.fetch_and_parse(feed_info.url)
     add_entries(feed.entries, feed_info)
     loop do
       sleep delay_interval
       feed = Feedzirra::Feed.update(feed)
       add_entries(feed.new_entries, feed_info) if feed.updated?
     end
   end

   # scope :date_select, lambda {|date1, date2| where("released_at between ? and ?", date1, date2)}

   def trended?(user)
    # raise user.posts.inspect
     if user.posts.where(:entry_feed_id => self.id).exists?
       return 1
     else
       return 2
     end
   end

   private

   def self.add_entries(entries, feed)
     entries.each do |entry|
       unless exists? :guid => entry.id
         create!(
           :feed_id       => feed.id,
           :title         => entry.title.sanitize,
           :summary      => entry.summary.blank? ? entry.summary : entry.summary.sanitize,
           :content     => entry.content.blank? ? entry.content : entry.content.sanitize,
           :url          => entry.url.sanitize,
           :published_at => entry.published,
           :guid         => entry.id,
           :like        => 0,
           :trend_count   => 0
         )
       the_entry = EntryFeed.where(:guid => entry.id).first
       EntryFeedTrend.create_trends(the_entry, entry)
      end
    end
   end


   define_index do
      indexes title
      indexes summary
      indexes content
      indexes feed.name
      indexes trends(:name), :as => :trend

      has published_at, :sortable => true
    end

end
