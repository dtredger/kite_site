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
  extend FriendlyId

  validates :name, presence: true, uniqueness: true

  belongs_to :country, optional: false

  friendly_id :name, use: :slugged
  acts_as_ordered_taggable_on :kiteable_months
  has_many_attached :photos
  has_one :location_map, as: :record, dependent: :destroy
  has_rich_text :content

  scope :with_eager_loaded_image, -> { eager_load(photos: :blob) }
  scope :with_preloaded_image, -> { preload(photos: :blob) }

  def self.all_months
    %w[Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec]
  end

  def self.find_tagged_kite_spots(months)
    KiteSpot.tagged_with(months, any: true)
  end

  def amenities
    %w[TBD]
  end

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
