# frozen_string_literal: true

require 'rails_helper'

def fill_in_trix_editor(id, content)
  find(:xpath, "//*[@id='#{id}']", visible: false).click.set(content)
end

RSpec.describe 'UserCreatesKitespots', type: :system do
  before do
    driven_by :selenium_chrome_headless
    create_dummy_data(6)
    User.create(email: 'test@mail.com',
                password: '123123123')
  end

  describe 'create KiteSpot' do
    let(:user) { User.first }
    let(:country) { Country.first }

    it 'saves and shows' do
      sign_in user
      visit '/kite_spots/new'

      fill_in 'kite_spot[name]', with: 'Sample Kite Spot'
      # fill_in 'photos'
      fill_in 'kite_spot[latitude]', with: 33
      fill_in 'kite_spot[longitude]', with: 180

      select('Sep', from: 'kite_spot[kiteable_months][]')
      select('Nov', from: 'kite_spot[kiteable_months][]')

      select country.name, from: 'kite_spot[country_id]'

      fill_in_trix_editor('kite_spot_content', 'Some sample descriptive content')

      click_button 'commit'

      expect(page).to have_current_path(%r{/kite_spots/sample-kite-spot})
      expect(page).to have_css('.kitespot-name', text: 'Sample Kite Spot')
    end
  end
end
