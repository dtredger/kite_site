# frozen_string_literal: true

# For creating records for system specs
module SystemSpecMacros
  # Will create kite_spot_count KiteSpots & kite_spot_count+country_count Countries
  def create_dummy_data(kite_spot_count=3, country_count=0)
    create_kite_spot_and_country(kite_spot_count)
    create_country_without_kite_spot(country_count)
  end

  # Creates #number Countries with LocationMaps
  def create_country_without_kite_spot(number)
    number.times do
      create(:country, :with_location_map)
    end
  end

  # Creates #number KiteSpots with LocationMaps and #number Countries without locationMaps
  def create_kite_spot_and_country(number)
    number.times do
      create(:kite_spot, :with_location_map, :with_2_kiteable_months)
    end
  end
end
