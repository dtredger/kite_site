require 'rails_helper'

RSpec.describe 'UserViewsProfiles', type: :system do
  before do
    driven_by :selenium_chrome_headless
    create_dummy_records(6)
  end

  context 'unauthenticated guest' do
    describe 'faves' do
      it 'redirects to login' do
        visit '/faves'
        expect(page).to have_current_path('/users/sign_in')
      end
    end

    describe 'profile' do
      it 'redirects to login' do
        visit '/profile'
        expect(page).to have_current_path('/users/sign_in')
      end
    end
  end

  context 'authenticated user' do
    let(:user) { User.first }
    let(:admin) { create(:admin) }
    let(:country) { Country.first }
    let(:kite_spot) { KiteSpot.first }

    log_in_user

    describe 'user settings' do
      it 'shows profile info' do
        visit '/profile'
        expect(page).to have_css('.text-block', text: user.email)
      end
    end

    describe 'faves' do
      before do
        user.favorite(country)
        user.favorite(kite_spot)
        visit '/faves'
      end

      it 'shows list of favourites' do
        # visit '/faves'
        expect(page).to have_css('.media-body', text: '2 Favourites')
      end

      it 'shows kitespot cards' do
        # visit '/faves'
        expect(page).to have_css('.card-img-overlay-bottom', text: kite_spot.name)
      end

      it 'shows country cards' do
        expect(page).to have_css('.hover-scale-bg-image', text: country.name)
      end
    end
  end
end
