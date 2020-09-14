# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Country.delete_all
countries = Country.create([
  {name: 'Canada', region: 'North America'},
  {name: 'United States', region: 'North America'},
  {name: 'Mexico', region: 'North America'},
  ])
countries.each do |country|
  puts "country:" country.name
end

KiteSpot.delete_all
kite_spots = KiteSpot.create([
  { name: 'Nitnat Lake',
    country: countries[0],
    monthly_conditions: 111111000000
  },
  { name: 'San Francisco',
    country: countries[1],
    monthly_conditions: 000111111000
  },
  { name: 'La Ventana',
    country: countries[2],
    monthly_conditions: 000000111111
  }
])
kite_spots.each do |spot|
  puts "spot:" + spot.name
end
