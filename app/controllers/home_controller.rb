class HomeController < ApplicationController
  before_filter :authenticate_user!
  helper_method :menu_select

  def index

    @post_group = params[:group].blank? ? nil : params[:group]

    @posts = case @post_group
      when nil then Post
      when "Friends" then Post.friends(@current_user)
      when "Family" then nil
      when "Colleagues" then nil
    end
    @posts = @posts.order("created_at DESC") unless @posts.blank?

    @menu_trends = menu_select
    @menu_selected = params[:menu_show]

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

    render(:layout => "home")
  end

  private

  def menu_select
    if params[:menu_show] == "top" || params[:menu_show].blank?
      Trend.order('trend_count DESC').limit(10)
    elsif params[:menu_show] == "follow"
      User.where(:id => current_user.id).first.trends.limit(10)
    elsif params[:menu_show] =="user"
      []
    end
  end

end
