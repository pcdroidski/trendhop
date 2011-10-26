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

  def create_groups(user)
    #Rake::Task["import:tracking:all"].invoke
    friends = Group.new(:name => "Friends", :user_id => user)
    friends.save
    family = Group.new(:name =>"Family", :user_id => user)
    family.save
    colleagues = Group.new(:name =>"Colleagues", :user_id => user)
    colleagues.save
  end


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
