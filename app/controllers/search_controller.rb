class SearchController < ApplicationController

  def index
    @header_title = "Results for " + params[:search].to_s
    @search = params[:search]

    @trends = Trend.search(@search)
    @posts = Post.search(@search)
    @users = User.search(@search)
    
    #Automatically selects model with most number of results
    model_array = ["trends", "posts", "users"]
    select_array = [@trends.count, @posts.count, @users.count]
    max = nil
    model_array.each do |set|
      if eval("@"+ set + ".count") >= select_array.max
        max = set
      end
    end
    @search_view = params[:search_view].blank? ? max : params[:search_view].to_s
    #End
    
  end
  
  def match_and_count(view)
    case view
    when "posts"
      return @posts.count
    when "users"
      return @users.count
    when "trends"
      return @trends.count
    end
  end
  helper_method :match_and_count
  
end
