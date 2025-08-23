# Odin Flight Booker

A Rails implementation of The Odin Project’s **Flight Booker** app. The goal is to build a small search-and-booking flow that lets a user:

* pick origin, destination, and date,
* see matching flights,
* choose a flight and number of passengers,
* enter passenger details,
* create a booking and see a confirmation screen (and optionally receive email).

**Project brief:** The Odin Project — Flight Booker: [https://www.theodinproject.com/lessons/ruby-on-rails-flight-booker](https://www.theodinproject.com/lessons/ruby-on-rails-flight-booker)

---

## Data architecture

### Core entities & relationships

```
Airport (1) ──< Flight >── (1) Airport
                 │
                 └──< Booking >──< Passenger
```

* **Airport**: Master data for airports (e.g., IATA-like code and a human name).
* **Flight**: A scheduled flight from one airport to another at a specific datetime with a set duration (and optionally capacity).
* **Booking**: A user’s reservation for a specific flight, with contact details and a status.
* **Passenger**: One row per traveler; attached to a booking via nested attributes.

### Suggested schema (PostgreSQL)

**airports**

* `id: bigserial PK`
* `code: string` (limit 3–5, **unique**, uppercase)
* `name: string`
* `city: string` (optional)
* `country: string` (optional)
* indexes: `index_airports_on_code (unique)`

**flights**

* `id: bigserial PK`
* `departure_airport_id: bigint FK -> airports`
* `arrival_airport_id: bigint FK -> airports`
* `departure_time: datetime`
* `duration_minutes: integer` (> 0)
* `seats_total: integer` (optional, default 100)
* `seats_available: integer` (optional, default 100)
* indexes:

  * `index_flights_on_route_date (departure_airport_id, arrival_airport_id, date(departure_time))`
  * `index_flights_on_departure_time`
* constraints:

  * `departure_airport_id <> arrival_airport_id`
  * `duration_minutes > 0`
  * `seats_available BETWEEN 0 AND seats_total`

**bookings**

* `id: bigserial PK`
* `flight_id: bigint FK -> flights`
* `contact_email: string`
* `contact_phone: string` (optional)
* `booking_reference: string` (**unique**, e.g., 6–8 uppercase alphanumerics)
* `status: integer` (Rails enum: `pending`, `confirmed`, `canceled`)
* `total_price_cents: integer` (optional)
* indexes:

  * `index_bookings_on_flight_id`
  * `index_bookings_on_booking_reference (unique)`

**passengers**

* `id: bigserial PK`
* `booking_id: bigint FK -> bookings`
* `first_name: string`
* `last_name: string`
* `email: string` (optional)
* `document_number: string` (optional)
* indexes: `index_passengers_on_booking_id`