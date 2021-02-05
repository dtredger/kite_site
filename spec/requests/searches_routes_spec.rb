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

    context 'signed in' do
      before { login_as(user) }

      pending 'shows custom search results' do
        fail "ie: cost of flights from user's location, whether visa required"
      end
    end
  end

end
