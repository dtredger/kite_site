# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'searches_routes', type: :request do
  let(:user) { create(:user) }

  # before do
  #   5.times do |x|
  #     create(:kite_spot, :with_2_month_tags, name: "kite_spot_number_#{x}")
  #     create(:country, name: "country_number_#{x}")
  #   end
  #   create(:country, name: 'country_without_spots')
  # end

  describe 'GET /searches' do
    context 'not signed in' do
      it 'accepts search param' do
        get search_path, params: { search: {name: 'test'} }
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'GET /search/advanced' do
    context 'signed-in user' do
      log_in_user

      it 'allows location-based search' do
        get search_advanced_path, params: { search: {max_distance:2000} }
        expect(response).to have_http_status(:ok)
      end
    end
  end

end



