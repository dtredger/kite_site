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
    latitude { 1.5 }
    longitude { 1.5 }
    zoom { 1 }
    name { 'MyString' }
    record_type { 'MyString' }
    record_id { 1 }
  end
end
