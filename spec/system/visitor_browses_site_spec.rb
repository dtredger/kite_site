# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'VisitorBrowsesSite', type: :system do
  # TODO: to take screenshot: take_screenshot

  before do
    driven_by :selenium_chrome_headless
    create_dummy_data(6)
  end

  context 'with desktop screen-size' do
    describe 'homepage' do
      it 'displays homepage' do
        visit '/'
        expect(page).to have_css('.display-3', text: I18n.t('main_header'))
      end
    end

    describe 'country pages' do
      describe '/countries' do
        it 'shows Countries grid' do
          visit '/countries'
          expect(page).to have_css('.resource-countries', count: 6)
        end
      end

      describe '/countries/:name' do
        it 'shows named country' do
          country = Country.all.sample
          visit "/countries/#{country.name}"
          expect(page).to have_css('.country-name', text: country.name)
        end
      end
    end

    describe 'kite_spot pages' do
      describe '/kite_spots' do
        it 'shows KiteSpots grid' do
          visit '/kite_spots'
          expect(page).to have_css('.resource-kite_spots', count: 6)
        end
      end

      describe '/kite_spots/:name' do
        it 'shows named kitespot' do
          kitespot = KiteSpot.all.sample
          visit "/kite_spots/#{kitespot.name}"
          expect(page).to have_css('.kitespot-name', text: kitespot.name)
        end
      end
    end
  end

  # TODO: test mobile sizes
  # context 'with mobile screen-size' do
  #   before do
  #     driven_by :selenium_chrome_headless, screen_size: [375, 667]
  #   end
  # end
end
