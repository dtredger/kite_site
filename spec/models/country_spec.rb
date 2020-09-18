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
require 'rails_helper'

RSpec.describe Country, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
