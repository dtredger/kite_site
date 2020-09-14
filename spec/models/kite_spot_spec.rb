# == Schema Information
#
# Table name: kite_spots
#
#  id                 :integer          not null, primary key
#  monthly_conditions :integer
#  name               :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  country_id         :integer
#
# Indexes
#
#  index_kite_spots_on_country_id  (country_id)
#
require 'rails_helper'

RSpec.describe KiteSpot, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
