# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'LocationMaps_routes', type: :request do
  let(:country) { create(:country) }

  describe 'GET /global-map' do
    it 'renders global_map' do
      get global_map_path
      expect(response.status).to eq(200)
    end
  end

  describe 'not implemented' do
    it 'does not show individual maps' do
      location_map = create(:location_map_for_country)
      get "/location_maps/#{location_map.id}"
      expect(response).to redirect_to(root_path)
    end

    it 'does not display #new page' do
      get '/location_maps/new'
      expect(response).to redirect_to(root_path)
    end

    it 'does not create location_map' do
      expect do
        post '/location_maps', params: { location_map: attributes_for(:location_map, record: country) }
      end.to raise_error(ActionController::RoutingError, 'No route matches [POST] "/location_maps"')
    end
  end
end
