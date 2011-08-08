class AddCountToTrendHop < ActiveRecord::Migration
  def change
     add_column :trend_hops, :count, :integer
  end
end
