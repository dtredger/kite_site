# == Schema Information
#
# Table name: kite_spots
#
#  id                 :integer          not null, primary key
#  description        :text
#  latitude           :float
#  longitude          :float
#  monthly_conditions :string
#  name               :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  country_id         :integer
#
# Indexes
#
#  index_kite_spots_on_country_id  (country_id)
#
FactoryBot.define do
  factory :kite_spot do
    name { "MyString" }
  end
end
