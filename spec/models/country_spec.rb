# == Schema Information
#
# Table name: countries
#
#  id            :integer          not null, primary key
#  name          :text
#  region        :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  kite_spots_id :integer
#  photos_id     :integer
#
# Indexes
#
#  index_countries_on_kite_spots_id  (kite_spots_id)
#  index_countries_on_photos_id      (photos_id)
#
require 'rails_helper'

RSpec.describe Country, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
