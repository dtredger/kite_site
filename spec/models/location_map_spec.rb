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
require 'rails_helper'

RSpec.describe LocationMap, type: :model do
	let(:location_map_for_kite_spot) { create(:location_map_for_kite_spot) }

	describe 'relations' do
		it 'requires name' do
			expect do
				create(:location_map_for_country, name: '')
			end.to raise_error(ActiveRecord::RecordInvalid)
		end

		it 'requires lat/lon' do
			expect do
				create(:location_map_for_country, latitude: nil, longitude: nil)
			end.to raise_error(ActiveRecord::RecordInvalid)
		end

		it 'polymorphic belongs_to Record' do
			expect(subject).to respond_to :record
		end

		describe 'dependent actions' do
			it 'does not destroys associated record' do
				location_map_for_kite_spot
				expect{location_map_for_kite_spot.destroy}.not_to change{KiteSpot.count}
			end
		end
	end

	describe 'methods' do
    context 'Class' do
      describe '#all_spots_map' do
        before(:each) do
          5.times { create(:location_map_for_country) }
        end

        it 'returns markers for all locations' do
          expect(LocationMap.all_spots_map[:markers].count). to eq(5)
        end
      end
    end

    context 'Instance' do
      describe '#leaflet_map_details' do
        it 'returns leaflet config obj' do
          expect(location_map_for_kite_spot.leaflet_map_details.keys).to eq([:container_id, :max_zoom, :center, :markers])
        end

        it 'centers on map coordinates' do
          expect(location_map_for_kite_spot.leaflet_map_details[:center][:latlng]).to eq([location_map_for_kite_spot.latitude, location_map_for_kite_spot.longitude])
        end
      end
    end

	end
end
