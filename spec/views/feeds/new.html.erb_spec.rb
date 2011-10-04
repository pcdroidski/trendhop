require 'spec_helper'

describe "feeds/new.html.erb" do
  before(:each) do
    assign(:feed, stub_model(Feed,
      :name => "MyString",
      :url => "MyString",
      :category_id => 1
    ).as_new_record)
  end

  it "renders new feed form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => feeds_path, :method => "post" do
      assert_select "input#feed_name", :name => "feed[name]"
      assert_select "input#feed_url", :name => "feed[url]"
      assert_select "input#feed_category_id", :name => "feed[category_id]"
    end
  end
end
