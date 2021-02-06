# frozen_string_literal: true

# == Schema Information
#
# Table name: kite_spots
#
#  id          :bigint           not null, primary key
#  description :text
#  latitude    :float
#  longitude   :float
#  name        :string
#  slug        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  country_id  :integer
#
# Indexes
#
#  index_kite_spots_on_country_id  (country_id)
#  index_kite_spots_on_name        (name) UNIQUE
#  index_kite_spots_on_slug        (slug) UNIQUE
#
require 'rails_helper'

RSpec.describe KiteSpot, type: :model do
  let(:kite_spot) { create(:kite_spot) }
  let(:kite_spot_with_map) { create(:kite_spot, :with_location_map) }
  let(:spot_with_2_months) { create(:kite_spot, :with_2_month_tags) }
  let(:spot_with_parking) { create(:kite_spot, :with_parking) }

  describe 'relations' do
    it 'requires name' do
      expect(build(:kite_spot, name: '')).not_to be_valid
    end

    it 'belongs_to Country' do
      expect(subject).to respond_to :country
    end

    describe 'Month tags' do
      it 'has month_tag_list' do
        expect(subject).to respond_to :month_tag_list
      end

      it 'has many month_tags' do
        expect(spot_with_2_months.month_tags.count).to eq(2)
      end
    end

    describe 'Amenities' do
      it 'has amenity tags' do
        expect(subject).to respond_to :amenity_tag_list
      end

      it 'has many amenities' do
        expect(spot_with_parking.amenity_tags.first.name).to include('parking')
      end
    end

    describe 'dependent actions' do
      it 'destroys associated LocationMap' do
        kite_spot_with_map = kite_spot
        kite_spot_with_map.create_location_map
        expect { kite_spot_with_map.destroy }.to change(LocationMap, :count).by(-1)
      end
    end
  end

  context 'search' do
    describe 'name' do
      it 'returns all partial matches' do
        aruba = create(:kite_spot, name: 'Aruba')
        argentina = create(:kite_spot, name: 'Argentina')
        expect(described_class.name_search('ar')).to eq([aruba, argentina])
      end
    end

    describe 'months' do
      it 'returns all matching months' do
        spot_with_2_months
        kite_spot.month_tag_list.add('Mar')
        kite_spot.save
        kite_spot_apr = create(:kite_spot)
        kite_spot_apr.month_tag_list.add('Mar')
        kite_spot_apr.save
        expect(described_class.month_search(%w[Mar Apr]).count).to eq(2)
      end
    end

    describe '#haversine_distance' do
      it 'calculates from user' do
        kite_spot_ten = create(:kite_spot, latitude: 10, longitude: 10)
        user_zero = create(:user, latitude: 0, longitude: 0)
        expect(kite_spot_ten.haversine_distance(user_zero)).to eq(1569)
      end
    end
  end

  describe 'wind_information' do
    let(:kite_spot) { create(:kite_spot, latitude: 10, longitude: 20) }

    it 'returns iframe' do
      zoom = 5
      expect(kite_spot.wind_information[:windy]).to match("https://www.windy.com/?10.0,20.0,#{zoom},")
    end
  end

  context 'scopes' do
    describe 'max_distance' do
      it 'filters kite spots' do
        target = {latitude: 0, longitude: 0}
        fifteen_hundred_km = create(:kite_spot, latitude: 10, longitude: 10)
        three_thousand_km = create(:kite_spot, latitude: 20, longitude: 20)
        expect(described_class.max_distance(2000, target)).to eq([fifteen_hundred_km])
      end
    end
  end
end
