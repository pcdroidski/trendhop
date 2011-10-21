class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :post_from_anywhere


  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    redirect_to root_url
  end

  private

  def post_from_anywhere
    @top_trends = Trend.order("trend_count ASC").limit(5)
    @special_post = Post.new()
    @current_user = current_user
  end

  def check_user?
    user_signed_in?
  end
  helper_method :check_user?

  def create_groups(user)
    #Rake::Task["import:tracking:all"].invoke
    friends = Group.new(:name => "Friends", :user_id => user)
    friends.save
    family = Group.new(:name =>"Family", :user_id => user)
    family.save
    colleagues = Group.new(:name =>"Colleagues", :user_id => user)
    colleagues.save
  end

  def list_trends(post)
    trend_list = []

    if (post.retrend_post_id == nil)
      post.trends.map do |trend|
        trend_list << "<a id='trend' href='#{url_for(trend_path(trend.name))}'>#{trend.name} </a>"
      end
    else
      repost = Post.where(:id => post.retrend_post_id).first
       repost.trends.map do |trend|
          trend_list << "<a id='trend' href='#{url_for(trend_path(trend.name))}'>#{trend.name} </a>"
        end
    end
    trend_list.to_sentence
  end
  helper_method :list_trends

  def is_follow_trend(trend)
    follow = UserFollowingTrend.where(:user_id => @current_user.id, :trend_id => trend.id).first
    follow
  end
  helper_method :is_follow_trend

  def is_friend?(user)
    friend = UserFriend.where(:user_id => @current_user.id, :friend_id => user.id).first
    friend
  end
  helper_method :is_friend?


end
