class SearchController < ApplicationController
  before_filter :authenticate_user!

  def index
    @header_title = params[:search].to_s
    @search = params[:search]

    @trends = Trend.search(@search)
    @posts = Post.search(@search)
    @users = User.search(@search)
    @blogs = EntryFeed.search(@search, :order => :published_at, :sort_mode => :asc)

    model_array = ["trends", "posts", "users", "blogs"]
    select_array = [@trends.count, @posts.count, @users.count, @blogs.count]
    max = nil
    model_array.each do |set|
      if eval("@"+ set + ".count") >= select_array.max
        max = set
      end
    end
    @search_view = params[:search_view].blank? ? max : params[:search_view].to_s

  end

  def match_and_count(view)
    case view
    when "posts"
      return @posts.count
    when "users"
      return @users.count
    when "trends"
      return @trends.count
    when "blogs"
      return @blogs.count
    end
  end
  helper_method :match_and_count

end
