class PostsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  # GET /posts
  # GET /posts.json
  def index
  #  @posts = Post.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  #  @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    retrend_post = params[:content]
    @post = Post.new(:content => retrend_post)
    @retrend = Trend.where(:id => params[:trend]).first
 #   @post.content = params[:post]

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @post }
    end
  end

  # GET /posts/1/edit
  def edit
 #   @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])
    @user = current_user
  #  raise @post.inspect
    trend_array=[]
    @post.content.split(" ").each do |str|
      if str.include?("#")
        trend = delete_chars(str)
 #         raise "#{trend.inspect} #{trend_array.inspect}"
        trend_array << trend if !trend_array.include?(trend)
      end
    end


    respond_to do |format|
      if @post.save
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

         @post_trend = PostTrend.where(:post_id => @post, :trend_id => @trend).first
         if @post_trend.blank?
            @post_trend = PostTrend.new()
            @post_trend.post_id = @post.id
            @post_trend.trend_id = @trend.id
            @post_trend.post_counter = 1
            @post_trend.save
          else
            @post_trend.post_counter += 1
            @post_trend.save
          end
        end


        format.html { redirect_to @post, :notice => 'Post was successfully created.' }
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
  #  @post = Post.find(params[:id])

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
    trend.delete("!").delete("@").delete("#").delete("*").delete("(").delete(")").downcase
  end


end
