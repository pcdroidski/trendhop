class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.references :blog
      t.text :body

      t.timestamps
    end
    add_index :comments, :blog_id
  end
end
