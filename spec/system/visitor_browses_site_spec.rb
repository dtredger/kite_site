# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'VisitorBrowsesSite', type: :system do
  # TODO: to take screenshot: take_screenshot

  before do
    driven_by :selenium_chrome_headless
    create_dummy_records(6)
  end

  context 'with desktop screen-size' do
    describe 'homepage' do
      it 'displays homepage' do
        visit '/'
        expect(page).to have_css('.display-3', text: I18n.t('site_name'))
      end
    end

    describe 'country pages' do
      describe '/countries' do
        it 'shows Countries cards' do
          visit '/countries'
          expect(page).to have_css('.hover-scale-bg-image', count: 6)
        end
      end

      describe '/countries/:name' do
        it 'shows named country' do
          country = Country.all.sample
          visit "/countries/#{country.slug}"
          expect(page).to have_css('.country-name', text: country.name)
        end
      end
    end

    describe 'kite_spot pages' do
      describe '/kite-spots' do
        it 'shows KiteSpots cards' do
          visit '/kite-spots'
          expect(page).to have_css('.card', count: 6)
        end
      end

      describe '/kite-spots/:name' do
        it 'shows named kitespot' do
          kitespot = KiteSpot.all.sample
          visit "/kite-spots/#{kitespot.slug}"
          expect(page).to have_css('h1', text: kitespot.name)
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
