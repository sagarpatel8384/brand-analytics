class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.string :street_address
      t.string :city
      t.string :state

      t.timestamps null: false
    end
  end
end
