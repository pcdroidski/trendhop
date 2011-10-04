require 'spec_helper'

describe "feeds/show.html.erb" do
  before(:each) do
    @feed = assign(:feed, stub_model(Feed,
      :name => "Name",
      :url => "Url",
      :category_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Url/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
