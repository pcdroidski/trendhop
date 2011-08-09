class CreateTrends < ActiveRecord::Migration
  def change
    create_table :trends do |t|
      t.string :name
      t.integer :trend_category_id
      t.integer :like_count
      t.integer :trend_count

      t.timestamps
    end
  end
end
