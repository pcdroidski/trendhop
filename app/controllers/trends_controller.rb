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
    @trend = Trend.where(:name => params[:id]).first
    @posts = @trend.posts.no_retrends


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
end
