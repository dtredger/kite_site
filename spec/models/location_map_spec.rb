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
  let(:user) { create(:user) }
  let(:location_map_for_kite_spot) { create(:location_map_for_kite_spot) }

  describe 'relations' do
    it 'polymorphic belongs_to Record' do
      expect(subject).to respond_to :record
    end

    it 'validates coordinates of parent Record' do
      user = create(:user, latitude: nil, longitude: nil)
      invalid_map = user.create_location_map
      expect(invalid_map).not_to be_valid
    end

    describe 'dependent actions' do
      it 'does not destroys associated record' do
        location_map_for_kite_spot
        expect { location_map_for_kite_spot.destroy }.not_to change(KiteSpot, :count)
      end
    end
  end

  describe 'methods' do
    context 'Class' do
      describe '#leaflet_map_details' do
        context 'empty map' do
          it 'centers on hardcoded midpoint' do
            map_details = described_class.leaflet_map_details
            expect(map_details[:center][:latlng]).to match([20.0, 0])
          end
        end

        describe 'all public locations' do
          before { create_list(:country, 5) }

          it 'returns markers for all locations' do
            expect(described_class.leaflet_map_details(:all)[:markers].count).to eq(5)
          end

          it 'does not map users' do
            user
            expect(described_class.leaflet_map_details(:all)[:markers].count).to eq(5)
          end
        end

        context 'when given models' do
          it 'creates markers for given models' do
            kite_spot = create(:kite_spot, latitude: 1, longitude: 2)
            kite_spot.create_location_map
            map_details = described_class.leaflet_map_details([kite_spot])
            expect(map_details[:markers].first[:latlng]).to match([1.0, 2.0])
          end

          it 'centers map on location' do
            kite_spot = create(:kite_spot, latitude: 1, longitude: 2)
            kite_spot.create_location_map
            map_details = described_class.leaflet_map_details([kite_spot])
            expect(map_details[:center][:latlng]).to match([1.0, 2.0])
          end

          it 'centers on avg lat/lon of array' do
            kite_spot_1 = create(:kite_spot, :with_location_map, latitude: 10, longitude: 10)
            kite_spot_2 = create(:kite_spot, :with_location_map, latitude: 30, longitude: 30)
            kite_spot_3 = create(:kite_spot, :with_location_map, latitude: 50, longitude: 50)
            map_details = described_class.leaflet_map_details([kite_spot_1, kite_spot_2, kite_spot_3])
            expect(map_details[:center][:latlng]).to match([30.0, 30.0])
          end
        end
      end
    end

    context 'Instance' do
      describe '#leaflet_map_details' do
        it 'returns leaflet config obj' do
          expect(location_map_for_kite_spot.leaflet_map_details.keys).to eq(%i[container_id max_zoom center markers])
        end

        it 'centers on map coordinates' do
          expect(
            location_map_for_kite_spot.leaflet_map_details[:center][:latlng]
          ).to eq([location_map_for_kite_spot.latitude,
                   location_map_for_kite_spot.longitude])
        end

        it 'returns correct URL' do
          loc_map = create(:location_map_for_kite_spot)
          slug = loc_map.record.slug
          expect(loc_map.popup_link).to match("<a href='http://localhost:3000/kite-spots/#{slug}'>#{loc_map.record
                                                                                                       .name}</a>")
        end
      end
    end
  end
end
