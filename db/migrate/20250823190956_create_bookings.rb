class CreateBookings < ActiveRecord::Migration[8.0]
  def change
    create_table :bookings do |t|
      t.references :flight, null: false, foreign_key: true
      t.string :contact_email
      t.string :contact_phone
      t.string :booking_reference
      t.integer :status
      t.integer :total_price_cents

      t.timestamps
    end
    add_index :bookings, :booking_reference
  end
end
