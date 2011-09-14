class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :post_from_anywhere
  layout 'application'

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    redirect_to root_url
  end



  private

  def post_from_anywhere
    @special_post = Post.new()
    @current_user = current_user
  end

  def check_user?
    user_signed_in?
  end
  helper_method :check_user?


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

end
