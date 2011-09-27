class CreatePostContents < ActiveRecord::Migration
  def change
    create_table :post_contents do |t|
      t.text :content
      t.timestamps
    end
  end
end
