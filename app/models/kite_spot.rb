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

  friendly_id :name, use: :slugged
  acts_as_ordered_taggable_on :kiteable_months
  has_many_attached :photos

  has_one :location_map, as: :record,
                         dependent: :destroy

  belongs_to :country, optional: false

  validates :name, presence: true, uniqueness: true

  has_rich_text :content

  def self.all_months
    %w[Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec]
  end

  def self.find_tagged_kite_spots(months)
    KiteSpot.tagged_with(months, any: true)
  end

  def amenities
    %w[beach parking test_amenity]
  end

  def card_subtitle
    country.name
  end

  def cover_photo
    photos.first
  end
end
