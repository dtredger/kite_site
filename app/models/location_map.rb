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
  belongs_to :record, polymorphic: true, optional: true

  validates :name,
            :latitude,
            :longitude,
            :record_type,
            :record_id, presence: true

  def zoom
    self[:zoom] || 10
  end

  def self.default_leaflet_map_center
    [40, 0]
  end

  def leaflet_map_details
    { container_id: 'location_map',
      max_zoom: 14,
      center: leaflet_map_center,
      markers: [leaflet_marker] }
  end

  def self.all_location_markers
    all_spots_arr = []
    LocationMap.find_each do |loc_map|
      all_spots_arr.push({ latlng: [loc_map['latitude'],
                                    loc_map['longitude']],
                           popup: loc_map.popup_link })
    end
    all_spots_arr
  end

  def self.all_spots_map
    { container_id: 'global_location_map',
      center: { latlng: self.default_leaflet_map_center },
      zoom: '2',
      markers: all_location_markers }
  end

  def popup_link
    "<a href='#{site_url}#{record_type.tableize}/#{record_id}'>#{name}</a>"
  end

  private

  def leaflet_map_center
    { latlng: [latitude, longitude],
      zoom: zoom }
  end

  def leaflet_marker
    { latlng: [latitude, longitude],
      popup: popup_link }
  end
end
