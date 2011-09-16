class FriendsController < ApplicationController
    before_filter :authenticate_user!
  # GET /friends
  # GET /friends.json
  def index
    @friends = UserFriend.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @friends }
    end
  end

  # GET /friends/1
  # GET /friends/1.json
  def show
    @friend = UserFriend.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @friend }
    end
  end

  # GET /friends/new
  # GET /friends/new.json
  def new
    @friend = UserFriend.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @friend }
    end
  end

  # GET /friends/1/edit
  def edit
    @friend = UserFriend.find(params[:id])
  end

  # POST /friends
  # POST /friends.json
  def create
    user_friend = User.find(params[:id])
    friend_group = Group.where(:name => params[:group_name], :user_id => @current_user.id).first
    @friend = UserFriend.new(:user_id => @current_user.id, :friend_id => user_friend, :group_id => friend_group)

    respond_to do |format|
      if @friend.save
        format.html { redirect_to user_friend, :notice => "You are now following #{user_friend.full_name}!" }
        format.json { render :json => @friend, :status => :created, :location => @friend }
      else
        format.html { render :action => "new" }
        format.json { render :json => @friend.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /friends/1
  # PUT /friends/1.json
  def update
    @friend = UserFriend.find(params[:id])

    respond_to do |format|
      if @friend.update_attributes(params[:friend])
        format.html { redirect_to @friend, :notice => 'Friend was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @friend.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /friends/1
  # DELETE /friends/1.json
  def destroy
    user = User.find(params[:id])
    @friend = UserFriend.where(:user_id => @current_user.id, :friend_id => user.id).first
    @friend.destroy

    respond_to do |format|
      format.html { redirect_to user, :notice => "You no longer follow #{user.full_name}." }
      format.json { head :ok }
    end
  end

end
