Airport.create!([
{ code: "WAW", name: "Warsaw" },
{ code: "KRK", name: "Kraków" },
{ code: "GDN", name: "Gdańsk" },
{ code: "BER", name: "Berlin" },
{ code: "CPH", name: "Copenhagen" }
])


waw = Airport.find_by(code: "WAW")
krk = Airport.find_by(code: "KRK")


3.times do |i|
Flight.create!(
departure_airport: waw,
arrival_airport: krk,
departure_time: (Date.current + i.days).change(hour: 10, min: 0),
duration_minutes: 55
)
end
