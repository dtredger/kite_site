require 'rails_helper'

RSpec.describe "Countries", type: :system do
  before do
    # driven_by :selenium, using: :headless_chrome, screen_size: [1400, 1400]
    # driven_by(:rack_test)
  end

  # context 'mobile' do
  #   before do
  #     driven_by :selenium, using: :chrome, screen_size: [375, 667]
  #   end
  # end

  describe 'countries#index' do
    it 'shows Countries grid' do
      visit '/countries'
      expect(page).to have_css('#grid-items')
    end
  end

end
