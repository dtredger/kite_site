# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Country.delete_all
# countries = Country.create([
#   {name: 'Canada', region: 'North America'},
#   {name: 'United States', region: 'North America'},
#   {name: 'Mexico', region: 'North America'},
#   ])
# countries.each do |country|
#   puts "country:" country.name
# end
#
KiteSpot.delete_all
# kite_spots = KiteSpot.create([
#   { name: 'Nitnat Lake',
#     country: countries[0],
#     monthly_conditions: 111111000000
#   },
#   { name: 'San Francisco',
#     country: countries[1],
#     monthly_conditions: 000111111000
#   },
#   { name: 'La Ventana',
#     country: countries[2],
#     monthly_conditions: 000000111111
#   }
# ])
# kite_spots.each do |spot|
#   puts "spot:" + spot.name
# end

LocationMap.delete_all

require 'csv'
csv_path_and_name = "#{Rails.root}/lib/assets/Sailing\ Sheet\ -\ Kite\ Spots.csv"
csv_text = File.read(csv_path_and_name)
csv_rows = CSV.parse(csv_text, headers: true)

csv_rows.each do |row|
	country_model = Country.find_or_create_by(name: row['Country'],
	                                          region: row['Region'])
	if row['notes'].blank?
		spot_description = "This spot in #{country_model.name} is good #{row['Good Months']} months a year. Region: #{row['Region']}"
	else
		spot_description = row['notes']
	end


	months = %w(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec)
	month_conditions_str = '000000000000'
	months.each_with_index do |month, ix|
		unless row[month].nil?
			month_conditions_str[ix] = '1'
		end
	end

	unless row['Location'].blank?
		spot_name = row['Location']
	else
		spot_name = "#{row['Country']} (all)"
	end

	spot = country_model.kite_spots.create(name: spot_name,
	                                       description: spot_description,
	                                       monthly_conditions: month_conditions_str)

	map = spot.create_location_map(name: "#{spot.name}, #{country_model.name}",
	                         latitude: row['Latitude'],
	                         longitude: row['Longitude'])

	puts "#{country_model.name} - #{spot_name} - #{map.latitude}, #{map.longitude}"
end

## use tags for months going forward
# KiteSpot.all.each do |kite_spot|
# 	kite_spot.monthly_conditions.each do |month|
# 			kite_spot.kiteable_month_list.add(month)
# 	end
# 	kite_spot.save
# end


# add maps to countries
require 'csv'
csv_path_and_name = "#{Rails.root}/lib/assets/country_locations.csv"
csv_text = File.read(csv_path_and_name)
csv_rows = CSV.parse(csv_text, headers: true)
csv_rows.each do |row|
	country = Country.find_by(name: row['name'])
	if country.location_map.nil?
		country.create_location_map(name: row['name'],
		                            latitude: row['latitude'],
		                            longitude: row['longitude'])
		puts "map for #{country.name}"
	else
		puts "map already exists for #{country.name}"
	end
end

# add (crude) descr to country
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'json'
require 'csv'

fails = []
Country.all.each do |country|
	country_name = country.name.gsub(" ", "_")
	page_url = "https://en.wikipedia.org/wiki/#{country_name}"

	begin
		noko_page = Nokogiri::HTML(open(page_url))

		first_100_words = noko_page.css('.mw-parser-output').css('p').text.squish().gsub("[1]","").gsub("[2]","").gsub("[3]","").gsub("[4]","").gsub("[5]","").truncate_words(100, omission: '...[via Wikipedia]')

		country.update(description: first_100_words)
		puts "#{country.name} updated"
	rescue => e
		puts "FAIL: #{country.name}: #{e}"
		fails.append(country.name)
	end

end


# attach images to country
file_path =
filename = 'antigua.jpg'
Country.photos.attach(io: File.open(file_path), filename: 'file.pdf')