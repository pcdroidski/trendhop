class CreatePostTrends < ActiveRecord::Migration
  def change
    create_table :post_trends do |t|
      t.integer :post_content_id
      t.integer :trend_id

      t.timestamps
    end
  end
end
