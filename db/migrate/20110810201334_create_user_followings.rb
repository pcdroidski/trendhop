class CreateUserFollowings < ActiveRecord::Migration
  def change
    create_table :user_followings do |t|
      t.integer :user_id
      t.integer :following_user_id

      t.timestamps
    end
  end
end
