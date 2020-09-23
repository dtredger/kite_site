# frozen_string_literal: true

# == Schema Information
#
# Table name: kite_spots
#
#  id                 :bigint           not null, primary key
#  description        :text
#  latitude           :float
#  longitude          :float
#  monthly_conditions :string
#  name               :string
#  slug               :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  country_id         :integer
#
# Indexes
#
#  index_kite_spots_on_country_id  (country_id)
#  index_kite_spots_on_name        (name) UNIQUE
#  index_kite_spots_on_slug        (slug) UNIQUE
#
require 'rails_helper'

RSpec.describe KiteSpot, type: :model do
	describe 'relations' do
		let(:kite_spot) { create(:kite_spot) }
		let(:kite_spot_with_map) { create(:kite_spot_with_location_map) }
		let(:spot_with_2_months) { create(:kite_spot_with_2_kiteable_months) }

		it 'requires name' do
			expect(build(:kite_spot, name: '')).not_to be_valid
		end

		it 'belongs_to Country' do
			expect(subject).to respond_to :country
		end

		describe 'Kiteable Months' do
			it 'has kiteable_month_list' do
				expect(subject).to respond_to :kiteable_month_list
			end

			it 'has_many kiteable_months tag objects' do
				expect(spot_with_2_months.kiteable_months.count).to eq(2)
			end
		end

		describe 'dependent actions' do

			it 'destroys associated LocationMap' do
				kite_spot_with_map
				expect{kite_spot_with_map.destroy}.to change{LocationMap.count}.by(-1)
			end
		end

	end
end
