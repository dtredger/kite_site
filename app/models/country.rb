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

  include Searchable

  validates :name, presence: true, uniqueness: true

  has_many_attached :photos, dependent: :destroy
  has_many :kite_spots, dependent: :nullify
  has_one :location_map, as: :record, dependent: :destroy
  has_rich_text :content

  # scope :with_eager_loaded_image, -> { eager_load(photos: :blob) }
  # scope :with_preloaded_image, -> { preload(photos: :blob) }

  # TODO: - this fetches all countries' kitespots' tags
  def self.find_months(months)
    all.filter { |c| c.includes_month?(months) }
  end

  def includes_month?(months)
    (month_tag_list & months).any?
  end

  def month_tag_list
    @wind_months ||= begin
      @wind_months = Set.new
      kite_spots.each do |spot|
        @wind_months.merge(spot.month_tag_list)
      end
      @wind_months
    end
  end

  # for grid subtitle
  def card_subtitle
    region
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
