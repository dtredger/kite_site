# frozen_string_literal: true

module DistanceCalculable
  extend ActiveSupport::Concern
  include Math

  EARTH_RADIUS_KM = 6371

  def get_obj_coords(coord_obj)
    return nil unless coord_obj.respond_to?(:latitude) && coord_obj.respond_to?(:longitude)

    { latitude: coord_obj.latitude, longitude: coord_obj.longitude }
  end

  def coord_radians(coords)
    coords = get_obj_coords(coords) unless coords.is_a?(Hash)
    return unless coords && coords[:latitude] && coords[:longitude]

    radians = ->(deg) { deg * PI / 180 }
    { lat: radians[coords[:latitude]], lng: radians[coords[:longitude]] }
  end

  def haversine_distance(to)
    from = coord_radians({ latitude: latitude, longitude: longitude })
    to = coord_radians(to)
    return unless from && to

    cosines_product = cos(to[:lat]) * cos(from[:lat]) * cos(from[:lng] - to[:lng])
    sines_product = sin(to[:lat]) * sin(from[:lat])
    (EARTH_RADIUS_KM * acos(cosines_product + sines_product)).round(0)
  end
end
