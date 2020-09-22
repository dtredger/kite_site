# == Schema Information
#
# Table name: location_maps
#
#  id          :integer          not null, primary key
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

  validates_presence_of :name,
                        :latitude,
                        :longitude,
                        :record_type,
                        :record_id


  def zoom
	  self[:zoom] || 10
  end

  def leaflet_map_details
    return if self.latitude.nil? || self.longitude.nil?
    {
      container_id: 'location_map',
      center: {
        latlng: [self.latitude, self.longitude],
        zoom: self.zoom
      },
      markers: [{
         latlng: [self.latitude, self.longitude],
         popup: self.popup_link(record_type, self.record.id, self.name)
      }],
      max_zoom: 14
    }
  end

	def self.all_spots_map
		all_spots_geo = []
		LocationMap.all.each do |loc_map|
			all_spots_geo.push({ latlng: [loc_map['latitude'], loc_map['longitude']],
			                     popup: self.popup_link(loc_map.record_type, loc_map.record_id, loc_map['name'])
			                   })

		end
		{
			container_id: 'global_location_map',
	    center: { latlng: [40, 0] },
	    zoom: '2',
			markers: all_spots_geo
		}
	end

	# TODO - handle site protocol
	def popup_link(record_type, record_id, record_name)
		"<a href='http://localhost:3000/#{record_type.tableize}/#{record_id}'>#{record_name}</a>"
	end

	def self.popup_link(record_type, record_id, record_name)
		popup_link(record_type, record_id, record_name)
	end


end