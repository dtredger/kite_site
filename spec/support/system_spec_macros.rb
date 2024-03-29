# frozen_string_literal: true

# For creating records for system specs
module SystemSpecMacros
  def fill_in_trix_editor(id, content)
    find(:xpath, "//*[@id='#{id}']", visible: false).click.set(content)
  end

  # Will create kite_spot_count KiteSpots & kite_spot_count+country_count Countries
  def create_dummy_records(kite_spot_count = 3, country_count = 0)
    create_kite_spot_and_country(kite_spot_count)
    create_country_without_kite_spot(country_count)
  end

  # Creates #number Countries with LocationMaps
  def create_country_without_kite_spot(number)
    number.times do
      country = create(:country)
      country.create_location_map
    end
  end

  # Creates #number KiteSpots with LocationMaps and #number Countries without locationMaps
  def create_kite_spot_and_country(number)
    number.times do
      kite_spot = create(:kite_spot, :with_2_month_tags)
      kite_spot.create_location_map
    end
  end

  # # remove files used in testing (db rollback never calls destroy)
  # def after_teardown
  #   super
  #   FileUtils.rm_rf("#{Rails.root}/storage_test")
  # end
end
