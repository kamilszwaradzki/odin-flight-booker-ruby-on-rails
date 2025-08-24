class Flight < ApplicationRecord
belongs_to :departure_airport, class_name: "Airport"
belongs_to :arrival_airport, class_name: "Airport"
has_many :bookings, dependent: :destroy

validates :departure_time, :duration_minutes, presence: true
end