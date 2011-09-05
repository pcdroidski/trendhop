class CreateCommentPosts < ActiveRecord::Migration
  def change
    create_table :comment_posts do |t|
      t.integer :commenter
      t.text :body
      t.references :post

      t.timestamps
    end
    add_index :comment_posts, :post_id
  end
end
