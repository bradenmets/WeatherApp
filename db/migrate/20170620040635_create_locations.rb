class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.integer :zipcode

      t.timestamps
    end
  end
end
