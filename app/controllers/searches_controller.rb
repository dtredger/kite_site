# frozen_string_literal: true

class SearchesController < ApplicationController
  skip_authorization_check
  before_action :search_resources

  def search
    # @months = search_params[:months].to_h.filter { |_key, val| val == '1' }.keys
    render template: 'pages/index'
  end

  def show
    @countries = Kaminari.paginate_array(@countries).page(params[:page]).per(10)
    @kite_spots = Kaminari.paginate_array(@kite_spots).page(params[:page]).per(10)
  end


  private

  def search_params
    params.require(:search).permit(:name, :distance, months: [], regions: [], amenities: [], languages: [])
  end

  def search_resources
    @countries = []
    @kite_spots = []
    return if params[:search].nil?

    name = search_params[:name]
    if name.present?
      name_countries = Country.name_search(name).includes(:kite_spots).to_a
      name_kite_spots = KiteSpot.name_search(name).includes(:country).to_a
    end

    all_months = %w[Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec]
    months = search_params[:months] & all_months
    if months.any?
      month_kite_spots = KiteSpot.month_search(months).includes(:country)
      month_countries = month_kite_spots.map(&:country).uniq
    end

    all_regions = ['Europe', 'Caribbean', 'South America', 'Asia', 'Africa', 'North America', 'Pacific', 'ANZA', 'Middle East']
    regions = search_params[:regions] & all_regions
    if regions.any?
      region_countries = Country.find_region(regions)
      kite_spots = []
      region_countries.each { |country| kite_spots << country.kite_spots }
      region_kite_spots = kite_spots.flatten(1).uniq
    end

    all_amenities = ['Parking', 'Change Rooms', 'Washrooms', 'Not Crowded', 'Easily Accessible', 'Camping', 'Waves', 'Flat Water']
    amenities = search_params[:amenities] & all_amenities
    if amenities.any?
      amenity_kite_spots = KiteSpot.find_amenities(amenities).includes(:country)
      amenity_countries = amenity_kite_spots.map(&:country).uniq
    end

    all_languages = %w[English French Spanish Italian German]
    languages = search_params[:languages] & all_languages
    if languages.any?
      language_countries = Country.find_language(languages)
      language_kite_spots = language_countries.map(&:kite_spots).flatten(1).uniq
    end

    max_distance = search_params[:distance].to_i
    target = {latitude: current_user.latitude, longitude: current_user.longitude}

    if (100..9999).include?(max_distance) && target[:latitude] && target[:longitude]
      distance_countries = Country.max_distance(max_distance, target)
      distance_kite_spots = KiteSpot.max_distance(max_distance, target)
    end

    name_countries ||= []
    month_countries ||= []
    region_countries ||= []
    amenity_countries ||= []
    language_countries ||= []
    distance_countries ||= []
    @countries = [name_countries, month_countries, region_countries, amenity_countries, language_countries, distance_countries].reject( &:empty? ).reduce(:&) || []

    name_kite_spots ||= []
    month_kite_spots ||= []
    region_kite_spots ||= []
    amenity_kite_spots ||= []
    language_kite_spots ||= []
    distance_kite_spots ||= []
    @kite_spots = [name_kite_spots, month_kite_spots, region_kite_spots, amenity_kite_spots, language_kite_spots, distance_kite_spots].reject( &:empty? ).reduce(:&) || []
  end

end
