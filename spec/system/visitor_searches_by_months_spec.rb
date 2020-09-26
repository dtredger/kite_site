# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'VisitorSearchesByMonths', type: :system do
  before do
    driven_by :selenium_chrome_headless
    create_dummy_data(6)
  end

  context 'on /kite_spots page' do
    it 'displays 12 month tags' do
      visit '/kite_spots'
      expect(page).to have_css('label.month-btn', count: 12)
      expect(page).to have_css('label.month-btn', text: 'Jan')
    end

    pending 'filters results' do
      raise('button disabling with js unsolved')
    end
  end
end
