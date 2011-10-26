class BlogsController < ApplicationController
  before_filter :authenticate_user!
 # load_and_authorize_resource
 # skip_load_resource :only => [:show, :refresh]

  # GET /blogs
  # GET /blogs.json
  def index
    feeds = []

    @blogs_filter = params[:filter].blank? ? "All" : params[:filter]

    @feeds = case @blogs_filter
    when "All" then UserFeed
    when "Politics" then UserFeed.politics
    when "Technology" then UserFeed.technology
    when "Science" then UserFeed.science
    when "Sports" then UserFeed.sports
    when "Health" then UserFeed.health
    when "Art_Design" then UserFeed.art
    when "Finance" then UserFeed.finance
    when "US" then UserFeed.us
    when "Business" then UserFeed.business
    when "Travel" then UserFeed.travel
    when "Entertainment" then UserFeed.entertainment
    when "World" then UserFeed.world
    end

    @feeds.where(:user_id => current_user.id).each do |feed|
      feeds << feed.feed_id unless feeds.include?(feed.feed_id)
    end

    @blogs = EntryFeed.where(:feed_id => feeds)
    @blogs = @blogs.order("published_at DESC") unless @blogs.blank?
    @blogs = @blogs.page(params[:page]).per(10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @blogs }
    end
  end

  # GET /refresh
  #POST /refresh
  def refresh
    @feeds = Feed.all
    feed_array = []
    @feeds.each do |f|
      EntryFeed.create_from_feed(f)
    end

    redirect_to blogs_path
    flash[:notice] = "Blogs successfully updated"
  end

  # GET /blogs/1
  # GET /blogs/1.json
  def show
    @blog = EntryFeed.where(:id => params[:id]).first

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @blog }
    end
  end

  # GET /blogs/new
  # GET /blogs/new.json
  def new
 #   @blog = Blog.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @blog }
    end
  end

  # GET /blogs/1/edit
  def edit
 #   @blog = Blog.find(params[:id])
  end

  # POST /blogs
  # POST /blogs.json
  def create
  #  @blog = Blog.new(params[:blog])
    @user = current_user

    trend_array=[]
    @blog.post.split(" ").each do |str|
      if str.include?("#")
        trend = delete_chars(str)
 #         raise "#{trend.inspect} #{trend_array.inspect}"
        trend_array << trend if !trend_array.include?(trend)
      end
    end


    respond_to do |format|
      if @blog.save
        trend_array.each do |t|
          @trend = Trend.where(:name => t).first
          if @trend.blank?
            @trend = Trend.new()
            @trend.name = t
            @trend.trend_count = 0
          end
          @trend.trend_count.blank? ? @trend.trend_count = 1 : @trend.trend_count += 1
          @trend.save

          @user_trend = UserTrend.where(:user_id => @user, :trend_id => @trend).first
          if @user_trend.blank?
            @user_trend = UserTrend.new()
            @user_trend.user_id = @user.id
            @user_trend.trend_id = @trend.id
            @user_trend.count = 1
            @user_trend.save
          else
            @user_trend.count.blank? ? @user_trend.count = 1 : @user_trend.count += 1
            @user_trend.save
          end

          hop_array = trend_array.reject{ |a| a== t}
          hop_array.each do |hop|
            @hop = Trend.where(:name => hop).first

            @trend_hop = TrendHop.where(:trend_id => @trend.id, :related_trend_id => @hop.id).first unless @hop.blank? || @trend.blank?
            if @trend_hop.blank?
              @trend_hop = TrendHop.new()
              @trend_hop.trend_id = @trend.id
              if @hop.blank?
                @hop = Trend.new()
                @hop.name = hop
                @hop.save
              end
              @trend_hop.related_trend_id = @hop.id
              @trend_hop.count = 0
            end
            @trend_hop.count += 1
            @trend_hop.save
          end

         @blog_trend = BlogTrend.where(:blog_id => @blog, :trend_id => @trend).first
         if @blog_trend.blank?
            @blog_trend = BlogTrend.new()
            @blog_trend.blog_id = @blog.id
            @blog_trend.trend_id = @trend.id
            @blog_trend.count = 1
            @blog_trend.save
          else
            @blog_trend.count += 1
            @blog_trend.save
          end
        end

        format.html { redirect_to @blog, :notice => 'Blog was successfully created.' }
        format.json { render :json => @blog, :status => :created, :location => @blog }
      else
        format.html { render :action => "new" }
        format.json { render :json => @blog.errors, :status => :unprocessable_entity }
      end
    end
  end


  # PUT /blogs/1
  # PUT /blogs/1.json
  def update
#    @blog = Blog.find(params[:id])

    respond_to do |format|
      if @blog.update_attributes(params[:blog])
        format.html { redirect_to @blog, :notice => 'Blogs was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @blog.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.json
  def destroy
 #   @blog = Blog.find(params[:id])
    @blog.destroy

    respond_to do |format|
      format.html { redirect_to blogs_url }
      format.json { head :ok }
    end
  end

  private


  def delete_chars(trend)
    trend.delete("!").delete("@").delete("#").delete("*").delete("(").delete(")").downcase
  end

end
