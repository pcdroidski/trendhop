class PostsController < ApplicationController
  before_filter :authenticate_user!
#  load_and_authorize_resource
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.search params[:search]

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
 #   render :layout => "post_show"
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post_content = PostContent.new()
    @post = Post.new()

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /retrends
  #POST /retrends.json
  def retrend
    session[:return_to] ||= request.referer
    retrend = Post.where(:id => params[:post_id]).first

    @post = Post.new(:post_content_id => retrend.post_content_id, :retrend_user_id => retrend.user_id, :retrend_post_id => retrend.id, :user_id => @current_user.id, :retrend => true)

    retrend.increment(:retrend_count)

    respond_to do |format|
      if @post.save
        retrend.save

        retrend.trends.each do |t|

          @trend = Trend.where(:name => t.name).first
          @trend.increment(:trend_count)
          @trend.save

          @user_trend = UserTrend.where(:user_id => @current_user, :trend_id => @trend).first
          if @user_trend.blank?
            @user_trend = UserTrend.new()
            @user_trend.user_id = @current_user.id
            @user_trend.trend_id = @trend.id
          end

          @user_trend.increment(:count)
          @user_trend.save
        end

        format.html { redirect_to session[:return_to], :notice => 'Post was successfully retrended!' }
        format.json { render :json => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.json { render :json => @post.errors, :status => :unprocessable_entity }
      end
    end
  end


  # DELETE /untrends
  #DELETE /untrends.json
  def untrend
    session[:return_to] ||= request.referer
    untrend = Post.where(:user_id => current_user.id, :retrend => true, :retrend_post_id => params[:post_id]).first
    untrend.trends.each do |t|
      @trend = Trend.where(:name => t.name).first
      @trend.decrement(:trend_count)
      @trend.save
      @user_trend = UserTrend.where(:user_id => @current_user, :trend_id => @trend).first

      @user_trend.decrement(:count)
      @user_trend.save
    end

    respond_to do |format|
      if untrend.destroy
        format.html { redirect_to session[:return_to], :notice => 'Post was successfully Un-Trended.' }
        format.json { head :ok }
      else
        format.html { redirect_to session[:return_to], :notice => 'There was a problem Un-Trending your post!' }
        format.json { head :ok }
      end
    end
  end

  # /GET Hide Post
  #/POST hide Post
  def hide
    session[:return_to] ||= request.referer
    hide_trend = Post.find(:id => params[:id])

  end

  # POST /posts
  # POST /posts.json
  def create
    @post_content = PostContent.new(params[:post][:post_content])
    @post_content.save
    @post = Post.new(:user_id => params[:post][:user_id], :post_content_id => @post_content.id, :entry_feed_id => params[:post][:entry_feed_id], :retrend => false)

    at_array =[]
    trend_array=[]
    @post.post_content.content.split(" ").each do |str|
      if str.include?("#")
        trend = delete_chars(str)
        trend_array << trend if !trend_array.include?(trend)
      end
      # if str.include?("@")
      #   str.delete("@")
      #
      #   at_array <<
      # end
    end

    respond_to do |format|
      if !trend_array.blank? && @post.save
        trend_array.each do |t|
          @trend = Trend.where(:name => t).first
          if @trend.blank?
            @trend = Trend.new()
            @trend.name = t
            @trend.like_count = 0
          end
          @trend.increment(:trend_count)
          @trend.save

          if !@post.entry_feed_id.blank?
            entry_feed = EntryFeed.where(:id =>@post.entry_feed_id).first
            entry_feed.increment(:trend_count)
          end

          @user_trend = UserTrend.where(:user_id => @current_user, :trend_id => @trend).first
          if @user_trend.blank?
            @user_trend = UserTrend.new()
            @user_trend.user_id = @current_user.id
            @user_trend.trend_id = @trend.id
          end
            @user_trend.increment(:count)
            @user_trend.save

          hop_array = trend_array.reject{ |a| a== t}

          hop_array.each do |hop|
            @hop = Trend.where(:name => hop).first

            @trend_hop = TrendHop.where(:trend_id => @trend.id, :related_trend_id => @hop.id).first unless @hop.blank?
            if @trend_hop.blank?
              @trend_hop = TrendHop.new()
              @trend_hop.trend_id = @trend.id
              if @hop.blank?
                @hop = Trend.new()
                @hop.name = hop
                @hop.save
              end
              @trend_hop.related_trend_id = @hop.id
            end
            @trend_hop.increment(:count)
            @trend_hop.save
          end

          @post_trend = PostTrend.where(:post_content_id => @post_content, :trend_id => @trend).first
          if @post_trend.blank?
            @post_trend = PostTrend.new()
            @post_trend.trend_id = @trend.id
            @post_trend.post_content_id = @post_content.id
          end
          @post_trend.save

        end

        format.html { redirect_to root_path, :notice => 'Post was successfully created.' }
        format.json { render :json => @post, :status => :created, :location => @post }
      else
        format.html { redirect_to root_path, :notice => 'You must include a trend!'}
        format.json { render :json => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, :notice => 'Post was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    session[:return_to] ||= request.referer
  #  @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to session[:return_to] }
      format.json { head :ok }
    end
  end

  def like
    session[:return_to] ||= request.referer
    @likeable = find_likeable.last
    @likeable_type = find_likeable.first
    @user_like = UserLike.new(:user_id => current_user.id, :source_id => @likeable.id, :source_type => @likeable_type)

    current_url = request.url

    if @user_like.save
      flash[:notice] = "Oh you like it!"
      redirect_to session[:return_to]
    else
      flash[:notice] = "There was an error!!!!"
     redirect_to session[:return_to]
    end
  end

  def unlike
    session[:return_to] ||= request.referer
    @likeable = find_likeable.last
    @likeable_type = find_likeable.first

    @user_like = UserLike.where(:user_id => current_user.id, :source_id => @likeable.id, :source_type => @likeable_type).first
    if @user_like.blank?
      @user_like = UserDislike.where(:user_id => current_user.id, :source_id => @likeable.id, :source_type => @likeable_type).first
    end

    @user_like.destroy

    respond_to do |format|
      format.html {redirect_to root_path }
      format.json {head :ok}
    end

  end

  def dislike
    session[:return_to] ||= request.referer
    @likeable = find_likeable.last
    @likeable_type = find_likeable.first
    @user_like = UserDislike.new(:user_id => current_user.id, :source_id => @likeable.id, :source_type => @likeable_type)

      current_url = request.url

      if @user_like.save
        flash[:notice] = "Oh you like it!"
        redirect_to session[:return_to]

      else
        flash[:notice] = "There was an error!!!!"
       redirect_to session[:return_to]

      end
  end

  private

  def delete_chars(trend)
    trend.delete("!").delete("@").delete("#").delete("*").delete("(").delete(")").delete("?").delete(".").delete(",").delete("<").delete(">").delete("/").delete('\\').delete("-")
  end

  def find_likeable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return [$1.classify, $1.classify.constantize.find(value)]
      end
    end
    nil
  end


end
