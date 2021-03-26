# frozen_string_literal: true

# == Schema Information
#
# Table name: location_maps
#
#  id          :bigint           not null, primary key
#  latitude    :float
#  longitude   :float
#  name        :string
#  record_type :string           not null
#  zoom        :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  record_id   :integer          not null
#
# Indexes
#
#  index_location_maps_on_record_type_and_record_id  (record_type,record_id)
#
class LocationMap < ApplicationRecord
  # KiteSpots & Countries have Location Maps
  belongs_to :record, polymorphic: true, optional: false

  validates :record_type,
            :record_id, presence: true
  validate :record_has_coordinates

  scope :public_maps, -> { includes(:record).filter { |c| PUBLIC_MAP_TYPES.include?(c.record_type) } }

  PUBLIC_MAP_TYPES = %w[Country KiteSpot]

  def latitude
    self[:latitude] || record.latitude if record
  end

  def longitude
    self[:longitude] || record.longitude if record
  end

  def zoom
    self[:zoom] || 8
  end

  def closest_markers
    return record.closest_5_kite_spots if record_type == 'User'

    []
  end

  def popup_link(model_obj = nil)
    if model_obj
      "<h6><a href='#{site_url}#{model_obj.class.name.tableize.dasherize}/#{model_obj.slug}'>#{model_obj.name}</a></h6>"
    else
      "<h6><a href='#{site_url}#{record_type.tableize.dasherize}/#{record.slug}'>#{record.name}</a></h6>"
    end
  end

  def leaflet_marker(model_obj = nil)
    if model_obj
      { latlng: [model_obj.latitude, model_obj.longitude], popup: popup_link(model_obj) }
    else
      { latlng: [latitude, longitude], popup: popup_link }
    end
  end

  # TODO: closest_markers for user should be separate
  def leaflet_map_details
    markers_arr = [leaflet_marker]
    closest_markers.each do |obj|
      markers_arr << leaflet_marker(obj)
    end
    { container_id: 'location_map',
      max_zoom: 14,
      center: leaflet_map_center,
      markers: markers_arr }
  end

  def self.leaflet_map_details(obj_arr = [], map_center = nil)
    all_location_markers = []
    if obj_arr == :all
      public_maps.each do |loc_map|
        all_location_markers.push(loc_map.leaflet_marker)
      end
    else
      obj_arr.each do |model|
        next unless model.location_map

        all_location_markers.push(model.location_map.leaflet_marker)
      end
    end

    map_center = calculate_center(all_location_markers) if map_center.nil?
    { container_id: 'location_map',
      center: { latlng: map_center },
      zoom: '2',
      markers: all_location_markers }
  end

  def self.calculate_center(loc_marker_arry)
    marker_count = loc_marker_arry.length
    return [20, 0] if marker_count == 0
    return loc_marker_arry.first[:latlng] if marker_count == 1

    lats = 0
    lons = 0
    loc_marker_arry.each do |marker|
      lats += marker[:latlng][0]
      lons += marker[:latlng][1]
    end
    [lats.to_f / marker_count.to_f, lons.to_f / marker_count.to_f]
  end

  private

  def leaflet_map_center
    { latlng: [latitude, longitude],
      zoom: zoom }
  end

  def record_has_coordinates
    errors.add(:base, 'Mapped object must have coordinates') unless record.latitude && record.longitude
  end
end
