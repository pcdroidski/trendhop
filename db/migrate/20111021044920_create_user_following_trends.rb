class CreateUserFollowingTrends < ActiveRecord::Migration
  def change
    create_table :user_following_trends do |t|
      t.integer :user_id
      t.integer :trend_id

      t.timestamps
    end
  end
end
