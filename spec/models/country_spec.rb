# frozen_string_literal: true

# == Schema Information
#
# Table name: countries
#
#  id          :bigint           not null, primary key
#  description :text
#  latitude    :float
#  longitude   :float
#  name        :text
#  region      :text
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

  describe 'dependent actions' do
    it 'destroys associated LocationMap' do
      country_with_location_map
      expect { country_with_location_map.destroy }.to change(LocationMap, :count).by(-1)
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

        expect(Country.name_search('ar')).to eq([aruba, argentina])
      end
    end

    describe 'months' do
      it 'returns all matching months' do
        create(:country_with_2_kitespots)
        spot = KiteSpot.first
        spot.month_tag_list.add('Mar')
        spot.save

        expect(Country.month_search(['Mar', 'Apr']).count).to eq(1)
      end
    end
  end
end
