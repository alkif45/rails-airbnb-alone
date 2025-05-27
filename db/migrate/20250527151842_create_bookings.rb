class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings do |t|
      t.references :flat, null: false, foreign_key: true
      t.references :guest, null: false, foreign_key: { to_table: :users }
      t.references :host, null: false, foreign_key: { to_table: :users }
      t.integer :number_of_guests
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
