require 'spec_helper'

describe "friends/show.html.erb" do
  before(:each) do
    @friend = assign(:friend, stub_model(Friend,
      :user_id => 1,
      :friend_id => 1,
      :group_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
