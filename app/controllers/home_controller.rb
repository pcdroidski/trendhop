class HomeController < ApplicationController
  before_filter :authenticate_user!

  def index
    @posts = Post.all
  end



end
