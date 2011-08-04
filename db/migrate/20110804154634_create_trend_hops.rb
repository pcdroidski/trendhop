class CreateTrendHops < ActiveRecord::Migration
  def change
    create_table :trend_hops do |t|
      t.integer :trend_id
      t.integer :related_trend_id

      t.timestamps
    end
  end
end
