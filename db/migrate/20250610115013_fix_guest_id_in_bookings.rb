class FixGuestIdInBookings < ActiveRecord::Migration[7.1]
  def change
    remove_column :bookings, :guest_id_id, :bigint
    add_reference :bookings, :guest, null: false, foreign_key: { to_table: :users }
  end
end
