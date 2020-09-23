# frozen_string_literal: true

# == Schema Information
#
# Table name: location_maps
#
#  id          :integer          not null, primary key
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
require 'rails_helper'

RSpec.describe LocationMap, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
