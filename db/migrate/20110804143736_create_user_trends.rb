class CreateUserTrends < ActiveRecord::Migration
  def change
    create_table :user_trends do |t|
      t.integer :user_id
      t.integer :trend_id

      t.timestamps
    end
  end
end
