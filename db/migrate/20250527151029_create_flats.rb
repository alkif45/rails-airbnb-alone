class CreateFlats < ActiveRecord::Migration[7.1]
  def change
    create_table :flats do |t|
      t.string :index
      t.string :show
      t.string :new
      t.string :create

      t.timestamps
    end
  end
end
