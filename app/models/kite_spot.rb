# == Schema Information
#
# Table name: kite_spots
#
#  id                 :integer          not null, primary key
#  monthly_conditions :integer
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

  validate :acceptable_image

  validates :name, presence: true



  def monthly_conditions
    months = ['Jan', 'Feb', 'Mar', 'Apr',
              'May', 'Jun', 'Jul', 'Aug',
              'Sep', 'Oct', 'Nov', 'Dec']
    str_conditions = self[:monthly_conditions].to_s.split('')
    good_conditions = []
    str_conditions.each_with_index do |pos, index|
      if pos == "1"
        good_conditions.push(months[index])
      end
    end
    return good_conditions
  end

  def amenities
    return ['beach', 'parking', 'test_amenity']
  end


  private

  def acceptable_image
    return unless cover_photo.attached?

    errors.add(:cover_photo, "EEEEEE")
  end

end
