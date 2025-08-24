# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_08_23_191005) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "airports", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bookings", force: :cascade do |t|
    t.bigint "flight_id", null: false
    t.string "contact_email"
    t.string "contact_phone"
    t.string "booking_reference"
    t.integer "status"
    t.integer "total_price_cents"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["booking_reference"], name: "index_bookings_on_booking_reference"
    t.index ["flight_id"], name: "index_bookings_on_flight_id"
  end

  create_table "flights", force: :cascade do |t|
    t.bigint "departure_airport_id", null: false
    t.bigint "arrival_airport_id", null: false
    t.datetime "departure_time", null: false
    t.integer "duration_minutes", null: false
    t.integer "seats_total", default: 100, null: false
    t.integer "seats_available", default: 100, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "date(departure_time)", name: "index_flights_on_departure_date"
    t.index ["arrival_airport_id"], name: "index_flights_on_arrival_airport_id"
    t.index ["departure_airport_id", "arrival_airport_id"], name: "index_flights_on_route"
    t.index ["departure_airport_id"], name: "index_flights_on_departure_airport_id"
    t.check_constraint "departure_airport_id <> arrival_airport_id", name: "chk_flights_diff_airports"
    t.check_constraint "duration_minutes > 0", name: "chk_flights_duration_positive"
    t.check_constraint "seats_available >= 0 AND seats_available <= seats_total", name: "chk_flights_seat_bounds"
  end

  create_table "passengers", force: :cascade do |t|
    t.bigint "booking_id", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "document_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["booking_id"], name: "index_passengers_on_booking_id"
  end

  add_foreign_key "bookings", "flights"
  add_foreign_key "flights", "airports", column: "arrival_airport_id"
  add_foreign_key "flights", "airports", column: "departure_airport_id"
  add_foreign_key "passengers", "bookings"
end
