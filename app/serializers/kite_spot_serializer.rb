# == Schema Information
#
# Table name: kite_spots
#
#  id          :bigint           not null, primary key
#  description :text
#  latitude    :float
#  longitude   :float
#  name        :string
#  slug        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  country_id  :integer
#
# Indexes
#
#  index_kite_spots_on_country_id  (country_id)
#  index_kite_spots_on_name        (name) UNIQUE
#  index_kite_spots_on_slug        (slug) UNIQUE
#
class KiteSpotSerializer
  include JSONAPI::Serializer
  attributes :name,
             :latitude,
             :longitude,
             :slug,
             :created_at,
             :updated_at,
             :month_tag_list,
             :amenity_tag_list

  attribute :content do |kite_spot|
    kite_spot.content.body.to_s
  end

  attribute :photos do |_kite_spot|
    # kite_spot.photos_attachments.map(&:service_url)
    ['https://dummyimage.com/600x400&text=first',
     'https://dummyimage.com/600x400&text=second',
     'https://dummyimage.com/600x400&text=third',
     'https://dummyimage.com/600x400&text=fourth',
     'https://dummyimage.com/600x400&text=fifth',
     'https://dummyimage.com/600x400&text=sixth']
  end

  belongs_to :country
  # has_one :location_map, as: :record, dependent: :destroy

  # # use rails cache with a separate namespace and fixed expiry
  cache_options store: Rails.cache, namespace: 'jsonapi-serializer', expires_in: 1.hour
end
