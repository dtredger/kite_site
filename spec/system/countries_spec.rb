# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Countries', type: :system do # context 'mobile' do
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
