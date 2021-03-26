# == Schema Information
#
# Table name: countries
#
#  id          :bigint           not null, primary key
#  description :text
#  language    :integer
#  latitude    :float
#  longitude   :float
#  name        :text
#  region      :integer
#  slug        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_countries_on_name  (name) UNIQUE
#  index_countries_on_slug  (slug) UNIQUE
#
class CountrySerializer
  include JSONAPI::Serializer
  attributes :name,
             :latitude,
             :longitude,
             :region,
             :slug,
             :created_at,
             :updated_at

  attribute :content do |country|
    country.content.body.to_s
  end

  attribute :photos do |_country|
    # country.photos_attachments.map(&:service_url)
    ['https://dummyimage.com/600x400&text=first',
     'https://dummyimage.com/600x400&text=second',
     'https://dummyimage.com/600x400&text=third',
     'https://dummyimage.com/600x400&text=fourth',
     'https://dummyimage.com/600x400&text=fifth',
     'https://dummyimage.com/600x400&text=sixth']
  end

  has_many :kite_spots

  cache_options store: Rails.cache, namespace: 'jsonapi-serializer', expires_in: 1.hour
end
