class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.integer :user_id
      t.integer :category_id
      t.string :title
      t.text :post
      t.string :url

      t.timestamps
    end
  end
end
