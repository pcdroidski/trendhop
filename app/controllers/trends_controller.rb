class TrendsController < ApplicationController
#  layout "trends", :except => [:index]
# layout 'application', :only => [:index]

  before_filter :authenticate_user!

 #   load_and_authorize_resource, :only => [:index, :new, :edit, :create, :update, :destroy ]

  # GET /trends
  # GET /trends.json
  def index
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
  #  raise @trends.inspect

    @posts = Post.order("created_at DESC")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @trends }
    end
  end

  # GET /trends/1
  # GET /trends/1.json
  def show
    @trend_search = params[:id].to_s
    @trends = Trend.search :conditions => {:name => params[:id] }
    if @trends.blank?
      @trends = Trend.where(:name => params[:id])
    end

    @trend_hops = trend_hops(@trends)
    @posts = get_trend_posts(@trends)
    @blogs = get_trend_blogs(@trends)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @trend }
    end
  end

  # GET /trends/new
  # GET /trends/new.json
  def new
    @trend = Trend.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @trend }
    end
  end

  # GET /trends/1/edit
  def edit
    @trend = Trend.find(params[:id])
  end

  # POST /trends
  # POST /trends.json
  def create
    @trend = Trend.new(params[:trend])

    respond_to do |format|
      if @trend.save
        format.html { redirect_to @trend, :notice => 'Trend was successfully created.' }
        format.json { render :json => @trend, :status => :created, :location => @trend }
      else
        format.html { render :action => "new" }
        format.json { render :json => @trend.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /trends/1
  # PUT /trends/1.json
  def update
    @trend = Trend.find(params[:id])

    respond_to do |format|
      if @trend.update_attributes(params[:trend])
        format.html { redirect_to @trend, :notice => 'Trend was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @trend.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /trends/1
  # DELETE /trends/1.json
  def destroy
    @trend = Trend.find(params[:id])
    @trend.destroy

    respond_to do |format|
      format.html { redirect_to trends_url }
      format.json { head :ok }
    end
  end

  def follow
    session[:return_to] ||= request.referer
    @trend = Trend.find(params[:id])
    @user_follow = UserFollowingTrend.new(:user_id => current_user.id, :trend_id => @trend.id)

    if @user_follow.save
      flash[:notice] = "Oh are not following #{@trend.name}"
      redirect_to session[:return_to]
    else
      flash[:notice] = "There was an error!!!!"
    end

  end

  def unfollow
    session[:return_to] ||= request.referer
    @trend = Trend.find(params[:id])
    @user_follow = UserFollowingTrend.where(:user_id => current_user.id, :trend_id => @trend.id).first

    @user_follow.destroy

    respond_to do |format|
      format.html {redirect_to session[:return_to]}
      format.json {head :ok}
    end
  end






  private

  def list_trend_categories(trends)
    categories = []
    trends.each do |trend|
      categories <<" " + trend.trend_category_id unless trend.trend_category_id.blank?
    end
    categories
  end
  helper_method :list_trend_categories
  
  def like_counts(trends)
    count = 0
    trends.each do |trend|
      count = count + trend.like_count unless trend.like_count.blank?
    end
    count
  end
  helper_method :like_counts

  def trend_counts(trends)
    count = 0
    trends.each do |trend|
      count = count + trend.trend_count unless trend.trend_count.blank?
    end
    count
  end
  helper_method :trend_counts

  def trend_hops(trends)
    hops = []
    trends.each do |trend|
      trend.trends.each do |hop|
        hops << hop
      end
    end
    hops
  end
  helper_method :trend_hops

  def get_trend_posts(trends)
    posts = []
    trends.each do |trend|
      trend.posts.no_retrends.each do |post|
        posts << post
      end
    end
    posts
  end
  
  def get_trend_blogs(trends)
    blogs =[]
    trends.each do |trend|
      EntryFeed.search(trend, :order => :published_at, :sort_mode => :asc).each do |blog|
        blogs << blog
      end
    end
    blogs
  end

end
