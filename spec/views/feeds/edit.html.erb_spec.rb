require 'spec_helper'

describe "feeds/edit.html.erb" do
  before(:each) do
    @feed = assign(:feed, stub_model(Feed,
      :name => "MyString",
      :url => "MyString",
      :category_id => 1
    ))
  end

  it "renders the edit feed form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => feeds_path(@feed), :method => "post" do
      assert_select "input#feed_name", :name => "feed[name]"
      assert_select "input#feed_url", :name => "feed[url]"
      assert_select "input#feed_category_id", :name => "feed[category_id]"
    end
  end
end
