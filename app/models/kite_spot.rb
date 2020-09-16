# == Schema Information
#
# Table name: kite_spots
#
#  id                 :integer          not null, primary key
#  description        :text
#  monthly_conditions :string
#  name               :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  country_id         :integer
#
# Indexes
#
#  index_kite_spots_on_country_id  (country_id)
#
class KiteSpot < ApplicationRecord
  # belongs_to :country
  has_one_attached :cover_photo
  has_one :location_map, as: :record

  belongs_to :country

  validate :acceptable_image
  validates :name, presence: true, uniqueness: true

	acts_as_ordered_taggable_on :kiteable_months


  def all_months
	  %w(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec)
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


  private

  def acceptable_image
    return unless cover_photo.attached?

    errors.add(:cover_photo, "EEEEEE")
  end

end
