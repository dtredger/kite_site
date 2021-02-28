# frozen_string_literal: true

# == Schema Information
#
# Table name: countries
#
#  id          :bigint           not null, primary key
#  description :text
#  language    :integer
#  latitude    :float
#  longitude   :float
#  name        :text
#  region      :integer
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

  include DistanceCalculable

  validates :name, presence: true, uniqueness: true

  has_many_attached :photos, dependent: :destroy
  has_many :kite_spots, dependent: :nullify
  has_one :location_map, as: :record, dependent: :destroy
  has_rich_text :content
  acts_as_favoritable

  enum region: ['Europe', 'Caribbean', 'South America', 'Asia', 'Africa', 'North America', 'ANZA/Pacific', 'Middle East']

  enum language: [:English, :French, :Spanish, :Italian, :German]

  # TODO: - this fetches all countries' kitespots' tags
  scope :find_months, ->(months) { all.filter { |c| c.includes_month?(months) } }
  scope :find_region, ->(regions) { all.filter { |c| regions.include? c.region } }
  scope :find_language, ->(language) { all.filter { |c| languages.include? c.language } }
  scope :max_distance, ->(max_km, target) { all.filter do |c|
                                              distance = c.haversine_distance(target)
                                              distance.present? && distance <= max_km
                                            end }
  # scope :with_eager_loaded_image, -> { eager_load(photos: :blob) }
  # scope :with_preloaded_image, -> { preload(photos: :blob) }

  def includes_month?(months)
    (month_tag_list & months).any?
  end

  def month_tag_list
    @month_tag_list ||= begin
      @month_tag_list = Set.new
      kite_spots.each { |spot| @month_tag_list.merge(spot.month_tag_list) }
      @month_tag_list
    end
  end

  def latitude
    return location_map.latitude if location_map && self[:latitude].nil?
    super
  end

  def longitude
    return location_map.longitude if location_map && self[:longitude].nil?
    super
  end

  def currency
    'Money'
  end


  # Presenters
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
    photos.includes([:blob]).take(3)
  end

end
