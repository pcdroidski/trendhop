class CreateUserLikes < ActiveRecord::Migration
  def change
    create_table :user_likes do |t|
      t.integer :user_id
      t.integer :source_id
      t.string :source_type

      t.timestamps
    end
  end
end
