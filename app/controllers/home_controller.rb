class HomeController < ApplicationController
  before_filter :authenticate_user!

  def index

    @posts = Post.order("created_at DESC")
  end



end
