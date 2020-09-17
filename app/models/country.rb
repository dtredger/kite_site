# == Schema Information
#
# Table name: countries
#
#  id          :integer          not null, primary key
#  description :text
#  name        :text
#  region      :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  photos_id   :integer
#
# Indexes
#
#  index_countries_on_photos_id  (photos_id)
#
class Country < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many_attached :photos, dependent: :destroy

	has_many :kite_spots

  has_one :location_map, as: :record

end
