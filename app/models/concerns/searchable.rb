# frozen_string_literal: true

# Searching module for countries and kite_spots
# tightly coupled to those two models, and relies on current_user
# also creates its own list of amenities, languages, months, etc.
module Searchable
  extend ActiveSupport::Concern

  class_methods do
    ## partial match for 'name' attribute
    #
    def name_search(name_str)
      return none if name_str.blank?

      where('slug like?', "%#{name_str.parameterize}%")
    end

    ## return all records with matching Months
    # relies on model's #find_months method
    def month_search(months_arr)
      camel_arr = months_arr.map(&:camelcase)
      find_months(camel_arr)
    end

    def region_search(region_arr)
      camel_arr = region_arr.map(&:camelcase)
      find_region(camel_arr)
    end

    # def amenity_search(amenities)
    # end
  end

  # TODO: ignores location
  # basic search
  def name_loc_cat_search(search_params)
    results = {}
    name = search_params[:name]
    return results unless name

    case search_params[:category]
    when 'All'
      results[:countries] = Country.name_search(name).includes(:kite_spots).to_a
      results[:kite_spots] = KiteSpot.name_search(name).includes(:country).to_a
    when 'Kite Spot'
      results[:countries] = []
      results[:kite_spots] = KiteSpot.name_search(name).includes(:country).to_a
    when 'Country'
      results[:countries] = Country.name_search(name).includes(:kite_spots).to_a
      results[:kite_spots] = []
    end
    results
  end

  # advanced search
  def advanced_search(adv_search_params)
    @countries = []
    @kite_spots = []
    return if params[:search].nil?

    # TODO: duplicated
    name = adv_search_params[:name]
    if name.present?
      name_countries = Country.name_search(name).includes(:kite_spots).to_a
      name_kite_spots = KiteSpot.name_search(name).includes(:country).to_a
    end

    # TODO: inject months
    all_months = %w[Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec]
    months = adv_search_params[:months] & all_months
    # TODO: nil-safe does not handle when months is false (but not nil)
    if months && months.any?
      month_kite_spots = KiteSpot.month_search(months).includes(:country)
      month_countries = month_kite_spots.map(&:country).uniq
    end

    # TODO: inject regions
    all_regions = ['Europe', 'Caribbean', 'South America', 'Asia', 'Africa', 'North America', 'Pacific', 'ANZA',
                   'Middle East']
    regions = adv_search_params[:regions] & all_regions
    if regions && regions.any?
      region_countries = Country.find_region(regions)
      kite_spots = []
      region_countries.each { |country| kite_spots << country.kite_spots }
      region_kite_spots = kite_spots.flatten(1).uniq
    end

    # TODO: inject amentities
    all_amenities = ['Parking', 'Change Rooms', 'Washrooms', 'Not Crowded', 'Easily Accessible', 'Camping', 'Waves',
                     'Flat Water']
    amenities = adv_search_params[:amenities] & all_amenities
    if amenities && amenities.any?
      amenity_kite_spots = KiteSpot.find_amenities(amenities).includes(:country)
      amenity_countries = amenity_kite_spots.map(&:country).uniq
    end

    # TODO: inject languages
    all_languages = %w[English French Spanish Italian German]
    languages = adv_search_params[:languages] & all_languages
    if languages && languages.any?
      language_countries = Country.find_language(languages)
      language_kite_spots = language_countries.flat_map(&:kite_spots).uniq
    end

    if current_user
      max_distance = adv_search_params[:distance].to_i
      target = { latitude: current_user.latitude, longitude: current_user.longitude }

      if (100..9999).cover?(max_distance) && target[:latitude] && target[:longitude]
        distance_countries = Country.max_distance(max_distance, target)
        distance_kite_spots = KiteSpot.max_distance(max_distance, target)
      end
    end

    name_countries ||= []
    month_countries ||= []
    region_countries ||= []
    amenity_countries ||= []
    language_countries ||= []
    distance_countries ||= []
    @countries = [name_countries, month_countries, region_countries, amenity_countries, language_countries,
                  distance_countries].reject(&:empty?).reduce(:&) || []

    name_kite_spots ||= []
    month_kite_spots ||= []
    region_kite_spots ||= []
    amenity_kite_spots ||= []
    language_kite_spots ||= []
    distance_kite_spots ||= []
    @kite_spots = [name_kite_spots, month_kite_spots, region_kite_spots, amenity_kite_spots, language_kite_spots,
                   distance_kite_spots].reject(&:empty?).reduce(:&) || []
  end
end
