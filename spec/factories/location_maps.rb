# frozen_string_literal: true

# == Schema Information
#
# Table name: location_maps
#
#  id          :bigint           not null, primary key
#  latitude    :float
#  longitude   :float
#  name        :string
#  record_type :string           not null
#  zoom        :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  record_id   :integer          not null
#
# Indexes
#
#  index_location_maps_on_record_type_and_record_id  (record_type,record_id)
#
FactoryBot.define do
  factory :location_map do
    sequence(:name) { |x| "location map #{x}" }
    latitude { 32.915 }
    longitude { 41.225 }
    zoom { 3 }
    # association :record, factory: [:kite_spot, :location_map]

    factory :location_map_for_kite_spot do
      sequence(:name) { |x| "kite_spot_location map #{x}" }
      latitude { 152.315 }
      longitude { 21.525 }
      zoom { 3 }
      association :record, factory: :kite_spot
    end

    factory :location_map_for_country do
      sequence(:name) { |x| "country_location map #{x}" }
      latitude { 152.315 }
      longitude { 21.525 }
      zoom { 3 }
      association :record, factory: :country
    end
  end
end
