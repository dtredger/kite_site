# frozen_string_literal: true

require 'rails_helper'

def create_dummy_data
  5.times do |_x|
    create(:kite_spot, :with_location_map, :with_2_kiteable_months)
    create(:country_with_2_kitespots, :with_location_map)
  end
end

RSpec.describe 'VisitorBrowses', type: :system do
  # context 'mobile' do
  #   to take screenshot - take_screenshot

  before do
    # driven_by :selenium, using: :chrome, screen_size: [375, 667]
    driven_by :selenium_chrome_headless
    create_dummy_data
  end

  describe 'countries#index' do
    it 'shows Countries grid' do
      visit '/countries'
      expect(page).to have_css('#grid-items')
    end
  end
end
