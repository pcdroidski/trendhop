class AddCountToUserTrendAndBlogTrend < ActiveRecord::Migration
  def change
    add_column :user_trends, :count, :integer
    add_column :blog_trends, :count, :integer
  end
end
