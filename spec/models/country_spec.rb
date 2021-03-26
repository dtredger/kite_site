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
require 'rails_helper'

RSpec.describe Country, type: :model do
  let(:country) { create(:country) }
  let(:country_with_2_spots) { create(:country_with_2_kitespots) }
  let(:country_with_location_map) { create(:country, :with_location_map) }

  describe 'relations' do
    it 'has_many KiteSpots' do
      expect(country_with_2_spots.kite_spots.count).to eq(2)
    end

    it 'has_many Photos' do
      expect(subject).to respond_to :photos
    end

    it 'has_one LocationMap' do
      expect(subject).to respond_to :location_map
    end

    it 'does not have a User' do
      expect(subject).not_to respond_to :user
    end
  end

  context 'methods' do
    describe 'favorites' do
      let(:user) { create(:user) }

      it 'is favoritable' do
        user.favorite(country)
        expect(country.favoritors).to eq([user])
      end
    end
  end

  describe 'dependent actions' do
    it 'destroys associated LocationMap' do
      loc_map_country = create(:country)
      loc_map_country.create_location_map
      expect { loc_map_country.destroy }.to change(LocationMap, :count).by(-1)
    end

    it 'does not destroy associated KiteSpots' do
      country_with_2_spots
      expect { country_with_2_spots.destroy }.not_to change(KiteSpot, :count)
    end
  end

  context 'search' do
    describe 'name' do
      it 'returns all partial matches' do
        aruba = create(:country, name: 'Aruba')
        argentina = create(:country, name: 'Argentina')

        expect(described_class.name_search('ar')).to eq([aruba, argentina])
      end
    end

    describe 'months' do
      it 'returns all matching months' do
        create(:country_with_2_kitespots)
        spot = KiteSpot.first
        spot.month_tag_list.add('Mar')
        spot.save

        expect(described_class.month_search(%w[Mar Apr]).count).to eq(1)
      end
    end

    describe 'region' do
      it 'returns matching regions' do
        aruba = create(:country, name: 'Aruba', region: 'Caribbean')
        barbuda = create(:country, name: 'Barbuda', region: 'Caribbean')
        create(:country, name: 'Argentina', region: 'South America')
        create(:country, name: 'USA', region: 'North America')

        expect(described_class.region_search(['Caribbean'])).to eq([aruba, barbuda])
      end
    end
  end

  context 'scopes' do
    describe 'max_distance' do
      it 'filters countries' do
        target = { latitude: 0, longitude: 0 }
        fifteen_hundred_km = create(:country, latitude: 10, longitude: 10)
        three_thousand_km = create(:country, latitude: 20, longitude: 20)
        expect(described_class.max_distance(2000, target)).to eq([fifteen_hundred_km])
      end
    end
  end
end
