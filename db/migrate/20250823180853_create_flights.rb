class CreateFlights < ActiveRecord::Migration[7.1]
  def change
    create_table :flights do |t|
      t.references :departure_airport, null: false, foreign_key: { to_table: :airports }
      t.references :arrival_airport,   null: false, foreign_key: { to_table: :airports }
      t.datetime :departure_time,      null: false
      t.integer  :duration_minutes,    null: false
      t.integer  :seats_total,         null: false, default: 100
      t.integer  :seats_available,     null: false, default: 100
      t.timestamps
    end

    add_index :flights, [ :departure_airport_id, :arrival_airport_id ], name: :index_flights_on_route
    add_index :flights, "(date(departure_time))", name: :index_flights_on_departure_date

    add_check_constraint :flights,
      "departure_airport_id <> arrival_airport_id",
      name: "chk_flights_diff_airports"

    add_check_constraint :flights,
      "duration_minutes > 0",
      name: "chk_flights_duration_positive"

    add_check_constraint :flights,
      "seats_available >= 0 AND seats_available <= seats_total",
      name: "chk_flights_seat_bounds"
  end
end
