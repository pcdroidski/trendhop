class EntryFeed < ActiveRecord::Base

  def self.update_from_feed(feed_info)
     feed = Feedzirra::Feed.fetch_and_parse(feed_info.url)
     add_entries(feed.entries, feed_info)
   end

   def self.update_from_feed_continuously(feed_info, delay_interval = 15.minutes)
     feed = Feedzirra::Feed.fetch_and_parse(feed_info.url)
     add_entries(feed.entries, feed_info)
     loop do
       sleep delay_interval
       feed = Feedzirra::Feed.update(feed)
       add_entries(feed.new_entries) if feed.updated?
     end
   end

   private

   def self.add_entries(entries, feed)
     entries.each do |entry|
       unless exists? :guid => entry.id
         create!(
           :feed_id       => feed.id
           :title         => entry.title,
           :summary      => entry.summary,
           :content     => entry.content,
           :url          => entry.url,
           :published_at => entry.published,
           :guid         => entry.id
         )
       end
     end
   end

end
