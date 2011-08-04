class CreateBlogTrends < ActiveRecord::Migration
  def change
    create_table :blog_trends do |t|
      t.integer :blog_id
      t.integer :trend_id

      t.timestamps
    end
  end
end
