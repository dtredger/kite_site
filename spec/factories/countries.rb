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
FactoryBot.define do
  factory :country do
    sequence(:name) { |x| "country_#{x}" }
    region { 'Europe' }
    sequence(:content) do |x|
      "This is the rich-text content for country #{x}"
    end
    latitude { 33.333 }
    longitude { 44.444 }

    factory :country_with_2_kitespots do
      kite_spots { build_list(:kite_spot, 2) }
    end

    factory :country_with_map do
      after(:create) { |country| create(:location_map, record: country) }
    end

    trait :with_location_map do
      after(:create) do |country|
        create(:location_map, record: country)
      end
    end

    # after(:create) do |article|
    #  create(:comment, article: article)
    # end
  end
end
