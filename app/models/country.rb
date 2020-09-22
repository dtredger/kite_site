# == Schema Information
#
# Table name: countries
#
#  id          :integer          not null, primary key
#  description :text
#  latitude    :float
#  longitude   :float
#  name        :text
#  region      :text
#  slug        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  photos_id   :integer
#
# Indexes
#
#  index_countries_on_photos_id  (photos_id)
#  index_countries_on_slug       (slug) UNIQUE
#
class Country < ApplicationRecord
	extend FriendlyId
	friendly_id :name, use: :slugged

  validates :name, presence: true, uniqueness: true

  has_many_attached :photos, dependent: :destroy

	has_many :kite_spots

  has_one :location_map, as: :record




	def cover_photo
		self.photos.first
	end

	def card_subtitle
		region
	end

	def kiteable_month_list
		wind_in_country_months = []
		self.kite_spots.each do |kite_spot|
			kite_spot.kiteable_months.each do |month|
				unless month.name.in? wind_in_country_months
					wind_in_country_months.push(month.name)
				end
			end
		end
		wind_in_country_months
	end

end
