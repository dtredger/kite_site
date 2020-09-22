# == Schema Information
#
# Table name: kite_spots
#
#  id                 :integer          not null, primary key
#  description        :text
#  latitude           :float
#  longitude          :float
#  monthly_conditions :string
#  name               :string
#  slug               :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  country_id         :integer
#
# Indexes
#
#  index_kite_spots_on_country_id  (country_id)
#  index_kite_spots_on_slug        (slug) UNIQUE
#
class KiteSpot < ApplicationRecord
	extend FriendlyId
	friendly_id :name, use: :slugged

  # belongs_to :country
  has_many_attached :photos
  has_one :location_map, as: :record

  belongs_to :country

  validates :name, presence: true, uniqueness: true

	acts_as_ordered_taggable_on :kiteable_months
	has_rich_text :content


  def self.all_months
	  %w(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec)
  end

  def self.find_tagged_kite_spots(months)
	  KiteSpot.tagged_with(months, any: true)
  end

  def monthly_conditions
    months = %w(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec)
    split_str = self[:monthly_conditions].split('')
    good_conditions = []
    split_str.each_with_index do |letter, ix|
      if letter == '1'
        good_conditions.push(months[ix])
      end
    end
    good_conditions
  end

  def amenities
	  %w(beach parking test_amenity)
  end

  def card_subtitle
		country.name
  end


  private


end
