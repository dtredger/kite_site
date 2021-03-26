# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'VisitorSearches', type: :system do
  before do
    driven_by :selenium_chrome_headless
    create_dummy_records(6)
    create(:kite_spot, name: 'searched name one')
    create(:kite_spot, name: 'searched name two')
  end

  context 'homepage search' do
    it 'finds matching kite spot' do
      visit '/'
      fill_in 'search[name]', with: 'searched name one'
      click_button 'commit'

      expect(page).to have_css('.card', text: 'searched name one', count: 1)
    end
  end

  context 'advanced search' do
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
      before do
        visit '/search/advanced'
        fill_in 'search[name]', with: 'nz'
        click_button 'commit'
      end

      it 'shows all names matching slug' do
        expect(page).to have_css('.card', count: 2)
      end

      pending 'has map' do
        raise('map has no styles')
        expect(page).to have_css('#location_map')
      end
    end

    # describe 'months search' do
    #   it 'returns kite_spots with matched month' do
    #     visit '/'
    #     check 'search[month[Oct]]'
    #     click_button 'commit'
    #
    #     expect(page).to have_css('.resource-kite_spots', count: 2)
    #   end
    #
    #   it 'returns country of matching kite spot' do
    #     visit '/'
    #     check 'search[month[Oct]]'
    #     click_button 'commit'
    #
    #     expect(page).to have_css('.resource-countries', count: 2)
    #   end
    # end
    #
    # # REGION
    # # LANGUAGES
    # # BEST MONTHS
    # # AMENITIES
    #
    # describe 'name and month search' do
    #   it 'returns spot that matches both and country' do
    #     visit '/'
    #     fill_in 'search[name]', with: 'nz'
    #     check 'search[month[Oct]]'
    #     click_button 'commit'
    #
    #     expect(page).to have_css('.resource-col', count: 1)
    #   end
    # end
  end
end
