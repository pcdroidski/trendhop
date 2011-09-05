class PostsController < ApplicationController
  before_filter :authenticate_user!
#  load_and_authorize_resource
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
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
    retrend = Post.where(:id => params[:post_id]).first

    @user = current_user
    @post = Post.new(:post_content_id => retrend.post_content_id, :retrend_user_id => retrend.user_id, :retrend_post_id => retrend.id, :user_id => @user.id, :retrend => true)

    retrend.increment(:retrend_count)

    respond_to do |format|
      if @post.save
        retrend.save

        retrend.trends.each do |t|

          @trend = Trend.where(:name => t.name).first
          @trend.increment(:trend_count)
          @trend.save

          @user_trend = UserTrend.where(:user_id => @user, :trend_id => @trend).first
          if @user_trend.blank?
            @user_trend = UserTrend.new()
            @user_trend.user_id = @user.id
            @user_trend.trend_id = @trend.id
          end

          @user_trend.increment(:count)
          @user_trend.save
        end

        format.html { redirect_to root_path, :notice => 'Post was successfully retrended!' }
        format.json { render :json => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.json { render :json => @post.errors, :status => :unprocessable_entity }
      end

    end
  end

  # POST /posts
  # POST /posts.json
  def create
    @post_content = PostContent.new(params[:post][:post_content])
    @post_content.save
    @post = Post.new(:user_id => params[:post][:user_id], :post_content_id => @post_content.id, :retrend => false)
    @user = current_user

    at_array =[]
    trend_array=[]
    @post.post_content.content.split(" ").each do |str|
      if str.include?("#")
        trend = delete_chars(str)
 #         raise "#{trend.inspect} #{trend_array.inspect}"
        trend_array << trend if !trend_array.include?(trend)
      end
      # if str.include?("@")
      #   str.delete("@")
      #   
      #   at_array <<
      # end
    end

    respond_to do |format|
      if @post.save
        trend_array.each do |t|
          @trend = Trend.where(:name => t).first
          if @trend.blank?
            @trend = Trend.new()
            @trend.name = t
          end
          @trend.increment(:trend_count)
          @trend.save

          @user_trend = UserTrend.where(:user_id => @user, :trend_id => @trend).first
          if @user_trend.blank?
            @user_trend = UserTrend.new()
            @user_trend.user_id = @user.id
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
        format.html { render :action => "new" }
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
  #  @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :ok }
    end
  end

    private

  def delete_chars(trend)
    trend.delete("!").delete("@").delete("#").delete("*").delete("(").delete(")").delete("?")
  end


end
