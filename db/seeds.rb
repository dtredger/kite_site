
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

# LocationMap.delete_all

require 'csv'
csv_path_and_name = "#{Rails.root}/lib/assets/Sailing\ Sheet\ -\ Kite\ Spots.csv"
csv_text = File.read(csv_path_and_name)
csv_rows = CSV.parse(csv_text, headers: true)

csv_rows.each do |row|
	country_model = Country.find_or_create_by(name: row['Country'],
	                                          region: row['Region'],
                                            latitude: row['Latitude'],
                                            longitude: row['Longitude'])

  next if country_model.errors.any?

  if row['notes'].blank?
		spot_description = "This spot in #{country_model.name} is good #{row['Good Months']} months a year. Region: #{row['Region']}"
	else
		spot_description = row['notes']
	end

	unless row['Location'].blank?
		spot_name = row['Location']
	else
		spot_name = "#{row['Country']} (all)"
	end

	spot = country_model.kite_spots.create(name: spot_name,
	                                       description: spot_description,
                                         latitude: row['Latitude'],
                                         longitude: row['Longitude'])

	months = %w(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec)
	months.each_with_index do |month, ix|
		unless row[month].nil?
			spot.month_tag_list.add(month)
		end
	end

	map = spot.create_location_map(name: "#{spot.name}, #{country_model.name}",
	                         latitude: row['Latitude'],
	                         longitude: row['Longitude'])

	puts "#{country_model.name} - #{spot_name} - #{map.latitude}, #{map.longitude}"

  rescue
    next

end



# # use tags for months going forward
# KiteSpot.all.each do |kite_spot|
# 	kite_spot.monthly_conditions.each do |month|
# 			kite_spot.month_tag_list.add(month)
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

	next unless country

	if country&.location_map.nil?
		country.create_location_map(name: row['name'],
		                            latitude: row['latitude'],
		                            longitude: row['longitude'])
		puts "map for #{country.name}"
	else
		puts "map already exists for #{country.name}"
	end
end
