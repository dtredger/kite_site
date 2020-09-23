# frozen_string_literal: true

class PagesController < ApplicationController
  def index
    @countries = Country.take(4)
    @kite_spots = KiteSpot.take(4)
  end
end
