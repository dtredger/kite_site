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

puts countries
# kite_spots = 
