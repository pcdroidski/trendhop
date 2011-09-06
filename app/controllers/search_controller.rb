class SearchController < ApplicationController

  def index
    @header_title = "Results for " + params[:search].to_s
    @search = params[:search]

    @trends = Trend.search(@search)
    @posts = Post.search(@search)
    @users = User.search(@search)
    @search_view = params[:search_view].blank? ? "trends" : params[:search_view].to_s
  end

end
