class HomeController < ApplicationController
  before_filter :authenticate_user!

  def index
      render :layout => "layouts/home.erb"
  #  raise params.inspect
    @post_group = params[:group].blank? ? nil : params[:group]

    @posts = case @post_group
      when nil then Post
      when "Friends" then Post.friends(@current_user)
    end
    @posts = @posts.order("created_at DESC")


    @trend_filter = params[:filter]

    @trends = case params[:filter]
      when "recent" then Trend.order("created_at DESC")
      when "popular" then Trend.order("trend_count DESC")
      when "today" then Trend.set_range("day")
      when "past_week" then Trend.set_range("week")
      when "past_month" then Trend.set_range("month")
      when "men" then Trend.set_men
      when "women" then Trend.set_women
      else Trend.order("created_at DESC")
    end
  end



end
