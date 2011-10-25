class FeedsController < ApplicationController
  before_filter :authenticate_user!
  # GET /feeds
  # GET /feeds.json
  def index
    @feeds = Feed.all

      # fetching a single feed
  #@feed = Feedzirra::Feed.fetch_and_parse("http://feeds.feedburner.com/PaulDixExplainsNothing")

 # @entries = @feed.entries

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @feeds }
    end
  end

  # GET /feeds/1
  # GET /feeds/1.json
  def show
    @feed = Feed.find(params[:id])
    @entries = EntryFeed.where(:feed_id => @feed.id)

    if @entries.blank?
      EntryFeed.create_from_feed(@feed)
      @entries = EntryFeed.where(:feed_id => @feed.id)
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @feed }
    end
  end

  # GET /feeds/new
  # GET /feeds/new.json
  def new
    @feed = Feed.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @feed }
    end
  end

  def create
    @feed = Feed.new(params[:feed])

    @e_feed = Feedzirra::Feed.fetch_and_parse(@feed.url)

    respond_to do |format|
      format.html #test.html.erb
    end
  end

  # GET /feeds/1/edit
  def edit
    @feed = Feed.find(params[:id])
  end

  # POST /feeds
  # POST /feeds.json
  def create_feed
    @feed = Feed.new(params[:feed])

    respond_to do |format|
      if @feed.save
        EntryFeed.create_from_feed(@feed)
        format.html { redirect_to @feed, :notice => 'Feed was successfully created.' }
        format.json { render :json => @feed, :status => :created, :location => @feed }
      else
        format.html { render :action => "new" }
        format.json { render :json => @feed.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /feeds/1
  # PUT /feeds/1.json
  def update
    @feed = Feed.find(params[:id])

    respond_to do |format|
      if @feed.update_attributes(params[:feed])
        format.html { redirect_to @feed, :notice => 'Feed was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @feed.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /feeds/1
  # DELETE /feeds/1.json
  def destroy
    @feed = Feed.find(params[:id])
    @feed.destroy

    respond_to do |format|
      format.html { redirect_to feeds_url }
      format.json { head :ok }
    end
  end

  def subscribe
    @feed = Feed.where(:id => params[:feed_id]).first
    subscribe = UserFeed.new(:user_id => current_user.id, :feed_id => @feed.id, :feed_group_id => @feed.feed_category_id)
    if subscribe.save
      flash[:notice] = "You have Subscribed to this Blog!"
      redirect_to feeds_path
    else
      flash[:notice] = "There was an error!!!!"
      redirect_to feeds_path
    end
  end

  def unsubscribe
    @feed = Feed.where(:id => params[:feed_id]).first
    subscribe = UserFeed.where(:user_id => current_user.id, :feed_id => @feed.id).first
    subscribe.destroy

    respond_to do |format|
      format.html { redirect_to feeds_path, :notice => "You have Unsubscribed to this post!" }
      format.json { head :ok }
    end
  end

  def is_subscribed?(feed)
    feed = UserFeed.where(:user_id => @current_user.id, :feed_id => feed.id).first
    feed
  end
  helper_method :is_subscribed?

  def get_entry_trends(entry)
    trends = []
    EntryFeedTrends.where(:entry_feed_id => entry.id).each do |get|
      trends << get.trend
    end
    trends
  end
  helper_method :get_entry_trends
end
