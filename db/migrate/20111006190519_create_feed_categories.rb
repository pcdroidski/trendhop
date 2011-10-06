class CreateFeedCategories < ActiveRecord::Migration
  def change
    create_table :feed_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
