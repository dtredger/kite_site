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
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  photos_id   :integer
#
# Indexes
#
#  index_countries_on_photos_id  (photos_id)
#
FactoryBot.define do
  factory :country do
    name { "MyText" }
    region { "MyText" }
    has_many { "" }
  end
end
