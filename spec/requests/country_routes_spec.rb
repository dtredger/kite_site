# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Countries_routes', type: :request do
  let(:kite_spot) { create(:kite_spot) }
  let(:country) { create(:country) }

  describe 'GET /countries' do
    it 'returns countries page' do
      get countries_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /countries/:id' do
    it 'returns specific spot page' do
      get country_path(country)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /countries/new' do
    context 'when unauthorized visitor' do
      it 'redirects unauthorized' do
        get new_country_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when authorized User' do
      log_in_user

      it 'shows new form' do
        get new_country_path
        expect(response.body).to match('Create Country')
      end
    end
  end

  describe 'POST /countries' do
    context 'when unauthorized visitor' do
      it 'does not create Country' do
        expect do
          post countries_path, params: { country: attributes_for(:country) }
        end.not_to change(Country, :count)
      end
    end

    context 'when authorized User' do
      log_in_user

      it 'creates new Country' do
        expect do
          post countries_path, params: { country: attributes_for(:country) }
        end.to change(Country, :count).by(1)
      end
    end
  end

  describe 'GET /countries/:id/edit' do
    context 'when unauthorized visitor' do
      it 'redirects unauthorized' do
        get edit_country_path(country)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when authorized User' do
      log_in_user

      it 'shows edit form' do
        get edit_country_path(country)
        expect(response.body).to match('Editing Country')
      end
    end
  end

  describe 'PATCH /countries/:id' do
    context 'when unauthorized visitor' do
      it 'does not update Country' do
        expect do
          patch country_path(country.id), params: { country: attributes_for(:country, name: 'new') }
          country.reload
        end.not_to change(country, :name)
      end
    end

    context 'when authorized User' do
      log_in_user

      it 'updates Country' do
        expect do
          patch country_path(country.id), params: { country: attributes_for(:country, name: 'new') }
          country.reload
        end.to change(country, :name)
      end
    end
  end

  describe 'DELETE /countries/:id' do
    context 'when unauthorized visitor' do
      it 'does not delete Country' do
        country
        expect { delete country_path(country) }.not_to change(Country, :count)
      end
    end

    context 'when authorized User' do
      log_in_user

      it 'deletes Country' do
        country
        expect { delete country_path(country) }.to change(Country, :count).by(-1)
      end
    end
  end
end
