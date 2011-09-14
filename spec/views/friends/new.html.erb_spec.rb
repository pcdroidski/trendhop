require 'spec_helper'

describe "friends/new.html.erb" do
  before(:each) do
    assign(:friend, stub_model(Friend,
      :user_id => 1,
      :friend_id => 1,
      :group_id => 1
    ).as_new_record)
  end

  it "renders new friend form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => friends_path, :method => "post" do
      assert_select "input#friend_user_id", :name => "friend[user_id]"
      assert_select "input#friend_friend_id", :name => "friend[friend_id]"
      assert_select "input#friend_group_id", :name => "friend[group_id]"
    end
  end
end
