# frozen_string_literal: true

class PagesController < ApplicationController
  def index
    @countries = Country.includes([:photos_attachments]).take(4)
    @kite_spots = KiteSpot.includes([:photos_attachments]).includes([:country]).take(4)
  end
end
