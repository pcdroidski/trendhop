class AddRetrendUserIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :retrend_user_id, :integer
    add_column :posts, :retrend_count, :integer
    add_column :posts, :retrend_post_id, :integer
  end
end
