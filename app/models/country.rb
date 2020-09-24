# frozen_string_literal: true

# == Schema Information
#
# Table name: countries
#
#  id          :bigint           not null, primary key
#  description :text
#  latitude    :float
#  longitude   :float
#  name        :text
#  region      :text
#  slug        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_countries_on_name  (name) UNIQUE
#  index_countries_on_slug  (slug) UNIQUE
#
class Country < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  validates :name, presence: true, uniqueness: true

  has_many_attached :photos, dependent: :destroy

  has_many :kite_spots, dependent: :nullify

  has_one :location_map, as: :record, dependent: :destroy

  def cover_photo
    photos.first
  end

  def card_subtitle
    region
  end

  def kiteable_month_list
    wind_in_country_months = []
    kite_spots.each do |kite_spot|
      kite_spot.kiteable_months.each do |month|
        wind_in_country_months.push(month.name) unless month.name.in? wind_in_country_months
      end
    end
    wind_in_country_months
  end
end
