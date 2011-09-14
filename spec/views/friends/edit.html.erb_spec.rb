require 'spec_helper'

describe "friends/edit.html.erb" do
  before(:each) do
    @friend = assign(:friend, stub_model(Friend,
      :user_id => 1,
      :friend_id => 1,
      :group_id => 1
    ))
  end

  it "renders the edit friend form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => friends_path(@friend), :method => "post" do
      assert_select "input#friend_user_id", :name => "friend[user_id]"
      assert_select "input#friend_friend_id", :name => "friend[friend_id]"
      assert_select "input#friend_group_id", :name => "friend[group_id]"
    end
  end
end
