# frozen_string_literal: true

module DistanceCalculable
  extend ActiveSupport::Concern
  include Math

  EARTH_RADIUS_KM = 6371

  def get_lat_lon(coord_obj)
    if coord_obj[:latitude]
      lat = coord_obj[:latitude]
    elsif coord_obj.latitude
      lat = coord_obj.latitude
    else
      return nil
    end
    if coord_obj[:longitude]
      lon = coord_obj[:longitude]
    elsif coord_obj.longitude
      lon = coord_obj.longitude
    else
      return nil
    end
    {latitude: lat, longitude: lon}
  end

  def coord_radians(coord_obj)
    coords = get_lat_lon(coord_obj)
    radians = lambda { |deg| deg * PI / 180 }
    {lat: radians[coords[:latitude]], lng: radians[coords[:longitude]]}
  end

  def haversine_distance(to)
    from = coord_radians({latitude: self.latitude, longitude: self.longitude})
    to = coord_radians(to)
    return unless from && to
    cosines_product = cos(to[:lat]) * cos(from[:lat]) * cos(from[:lng] - to[:lng])
    sines_product = sin(to[:lat]) * sin(from[:lat])
    (EARTH_RADIUS_KM * acos(cosines_product + sines_product)).round(0)
  end
end
