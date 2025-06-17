class CreateFlats < ActiveRecord::Migration[7.1]
  def change
    create_table :flats do |t|
      t.string :title
      t.text :description
      t.integer :number_of_bathrooms
      t.integer :number_of_beds
      t.integer :guests_limit
      t.float :price_per_night
      t.string :property_type
      t.boolean :available

      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
