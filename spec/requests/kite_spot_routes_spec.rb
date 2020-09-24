# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'KiteSpots_routes', type: :request do
  let(:country) { create(:country) }
  let(:kite_spot) { create(:kite_spot) }

  describe 'GET /kite_spots' do
    it 'returns kite_spots page' do
      get kite_spots_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /kite_spots/:id' do
    it 'returns specific spot page' do
      get kite_spot_path(kite_spot)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /kite_spots/new' do
    context 'unauthorized visitor' do
      it 'redirects unauthorized' do
        get new_kite_spot_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'authorized User' do
      log_in_user

      it 'shows new form' do
        get new_kite_spot_path
        expect(response.body).to match('New Kite Spot')
      end
    end
  end

  describe 'POST /kite_spots' do
    context 'unauthorized visitor' do
      it 'does not create KiteSpot' do
        expect do
          post kite_spots_path, params: { kite_spot: attributes_for(:kite_spot, country_id: country.id) }
        end.not_to change(KiteSpot, :count)
      end
    end

    context 'authorized User' do
      log_in_user

      it 'creates new KiteSpot' do
        expect do
          post kite_spots_path, params: { kite_spot: attributes_for(:kite_spot, country_id: country.id) }
        end.to change(KiteSpot, :count).by(1)
      end
    end
  end

  describe 'GET /kite_spots/:id/edit' do
    context 'unauthorized visitor' do
      it 'redirects unauthorized' do
        get edit_kite_spot_path(kite_spot)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'authorized User' do
      log_in_user

      it 'shows edit form' do
        get edit_kite_spot_path(kite_spot)
        expect(response.body).to match('Editing Kite Spot')
      end
    end
  end

  describe 'PATCH /kite_spots/:id' do
    context 'unauthorized visitor' do
      it 'does not update KiteSpot' do
        expect do
          patch kite_spot_path(kite_spot.id), params: { kite_spot: attributes_for(:kite_spot, name: 'new') }
          kite_spot.reload
        end.not_to change(kite_spot, :name)
      end
    end

    context 'authorized User' do
      log_in_user

      it 'updates KiteSpot' do
        expect do
          patch kite_spot_path(kite_spot.id), params: { kite_spot: attributes_for(:kite_spot, name: 'new') }
          kite_spot.reload
        end.to change(kite_spot, :name)
      end
    end
  end

  describe 'DELETE /kite_spots/:id' do
    context 'unauthorized visitor' do
      it 'does not delete KiteSpot' do
        kite_spot
        expect { delete kite_spot_path(kite_spot) }.not_to change(KiteSpot, :count)
      end
    end

    context 'authorized User' do
      log_in_user

      it 'deletes KiteSpot' do
        kite_spot
        expect { delete kite_spot_path(kite_spot) }.to change(KiteSpot, :count).by(-1)
      end
    end
  end
end
