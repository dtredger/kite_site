# frozen_string_literal: true

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
class KiteSpot < ApplicationRecord
  include Searchable

  extend FriendlyId
  friendly_id :name, use: :slugged

  validates :name, presence: true, uniqueness: true
  belongs_to :country, optional: false

  acts_as_ordered_taggable_on :month_tags

  acts_as_ordered_taggable_on :amenity_tags

  has_many_attached :photos
  has_one :location_map, as: :record, dependent: :destroy
  has_rich_text :content

  scope :find_months, ->(months) { tagged_with(months, any: true) }

  def amenities
    amenity_tag_list
  end

  def latitude
    return location_map.latitude if location_map && self[:latitude].nil?
    super
  end

  def longitude
    return location_map.longitude if location_map && self[:longitude].nil?
    super
  end

  def wind_information
    zoom = 5
    {
      wind_history: "http://windhistory.com/map.html##{zoom}/#{latitude}/#{longitude}",
      windy: "https://www.windy.com/?#{latitude},#{longitude},#{zoom},",
      windfinder: "https://www.windfinder.com/##{zoom}/#{latitude}/#{longitude}"
    }
  end


  # TODO: - presenters moved elsewhere
  # for grid subtitle
  def card_subtitle
    country.name
  end

  # for grid card
  def cover_photo
    photos.first
  end

  # for #show page gallery
  def header_photos
    photos.take(3)
  end
end
