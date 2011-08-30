class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.integer :category_id
      t.integer :post_content_id
      t.integer :like
      t.boolean :retrend
      t.integer :retrend_user_id
      t.integer :retrend_post_id
      t.integer :retrend_count

      t.timestamps
    end
  end
end
