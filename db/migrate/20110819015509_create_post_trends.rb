class CreatePostTrends < ActiveRecord::Migration
  def change
    create_table :post_trends do |t|
      t.integer :post_id
      t.integer :trend_id
      t.integer :post_counter

      t.timestamps
    end
  end
end
