class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings do |t|
      t.date :start_date
      t.date :end_date
      t.string :status, default: "pending"
      t.integer :total_price

      t.references :guest_id, foreign_key: { to_table: :users }, null: false
      t.references :flat, null: false, foreign_key: true

      t.timestamps
    end
  end
end
