# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'VisitorSearches', type: :system do
  before do
    driven_by :selenium_chrome_headless
    create_dummy_records(6)
  end

  context 'month filter' do
    describe 'on /kite_spots page' do
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

  context 'full search' do
    before do
      create(:country, name: 'Tanzania')
      oct_beach = create(:kite_spot, name: 'Oct Beach')
      oct_beach.month_tag_list.add('Oct')
      oct_beach.save
      zanzibar_beach = create(:kite_spot, name: 'Zanzibar Beach')
      zanzibar_beach.month_tag_list.add('Oct')
      zanzibar_beach.save
    end

    describe 'name search only' do
      it 'shows all names matching slug' do
        visit '/'
        fill_in 'search[name]', with: 'nz'
        click_button 'commit'

        expect(page).to have_css('.resource-col', count: 2)
      end
    end

    describe 'months search' do
      it 'returns kite_spots with matched month' do
        visit '/'
        check 'search[month[Oct]]'
        click_button 'commit'

        expect(page).to have_css('.resource-kite_spots', count: 2)
      end

      it 'returns country of matching kite spot' do
        visit '/'
        check 'search[month[Oct]]'
        click_button 'commit'

        expect(page).to have_css('.resource-countries', count: 2)
      end
    end

    describe 'name and month search' do
      it 'returns spot that matches both and country' do
        visit '/'
        fill_in 'search[name]', with: 'nz'
        check 'search[month[Oct]]'
        click_button 'commit'

        expect(page).to have_css('.resource-col', count: 1)
      end
    end
  end
end
