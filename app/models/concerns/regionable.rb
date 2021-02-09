module Regionable
  extend ActiveSupport::Concern

  REGION_ENUM_IDS = {
      'europe':         0,
      'caribbean':      1,
      'south-america':  2,
      'asia':           3,
      'africa':         4,
      'north-america':  5,
      'anza-pacific':   6,
      'middle-east':    7
  }

  REGION_MAP_CENTERS = {
      'europe':         [-10, 30],
      'caribbean':      [40, 20],
      'south-america':  [50, -20],
      'asia':           [-50, 10],
      'africa':         [40, 20],
      'north-america':  [60, 30],
      'anza-pacific':   [-100, 0],
      'middle-east':    [-20, 10]
  }

  REGION_BLURBS = {
      'europe':         I18n.t('regions.blurbs.europe'),
      'caribbean':      I18n.t('regions.blurbs.caribbean'),
      'south-america':  I18n.t('regions.blurbs.south_america'),
      'asia':           I18n.t('regions.blurbs.asia'),
      'africa':         I18n.t('regions.blurbs.africa'),
      'north-america':  I18n.t('regions.blurbs.north_america'),
      'anza-pacific':   I18n.t('regions.blurbs.anza_pacific'),
      'middle-east':    I18n.t('regions.blurbs.middle_east')
  }

  def region_details(region_name='')
    # @region_details ||= begin
      region_details = {}
      name_sym = region_name.to_sym
      if REGION_ENUM_IDS.keys.include?(name_sym)
        region_details[:region_name]   = name_sym
        region_details[:countries]     = Country.where(region: REGION_ENUM_IDS[name_sym])
        region_details[:lat_lon_arr]   = REGION_MAP_CENTERS[name_sym]
        region_details[:region_blurb]  = REGION_BLURBS[name_sym]
      else
        # TODO - global map uses same route with global name?
        region_details[:region_name]   = 'Not Set'
        region_details[:countries]     = ''
        region_details[:lat_lon_arr]   = Country.none
        region_details[:region_blurb]  = [40, 10]
      end

      kite_spots = []
      region_details[:countries].each do |country|
        kite_spots += country.kite_spots
      end
      region_details[:kite_spots] = kite_spots
      region_details[:kite_spots_count] = kite_spots.count
      region_details
    end
  # end

end
