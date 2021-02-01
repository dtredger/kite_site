# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Countries_routes', type: :request do
  let(:kite_spot) { create(:kite_spot) }
  let(:country) { create(:country) }
  let(:user) { create(:user) }

  describe 'GET /profile' do
    context 'not signed in' do
      it 'redirects to login' do
        get profile_path
        expect(response).to have_http_status(:redirect)
      end
    end

    context 'signed in' do
      before { login_as(user) }

      it 'shows profile page' do
        get profile_path
        expect(response).to have_http_status(:ok)
      end
    end
  end

end
