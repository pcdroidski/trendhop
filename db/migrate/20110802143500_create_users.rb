class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :domain
      t.string :first_name
      t.string :last_name
      t.string :city
      t.integer :state_id
      t.character :sex
      t.integer :birth_day
      t.integer :birth_month
      t.integer :birth_year

      t.timestamps
    end
  end
end
