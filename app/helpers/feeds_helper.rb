module FeedsHelper

  def is_subscribed?(feed)
    feed = UserFeed.where(:user_id => @current_user.id, :feed_id => feed.id).first
    feed
  end

end
