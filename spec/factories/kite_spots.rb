# frozen_string_literal: true

# == Schema Information
#
# Table name: kite_spots
#
#  id                 :bigint           not null, primary key
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
FactoryBot.define do
  factory :kite_spot do
    sequence(:name) { |x| "kite_spot_#{x}" }
    sequence(:description) do |x|
      "description #{x} for kite spots"
    end
    latitude { 11.111 }
    longitude { 22.222 }
  end
end
