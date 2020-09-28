# frozen_string_literal: true

class PagesController < ApplicationController
  def index
    # @countries = Country.includes([:photos_attachments]).take(4)
    # @kite_spots = KiteSpot.includes([:photos_attachments]).includes([:country]).take(4)
    @countries = Country.with_attached_photos.take(4)
    @kite_spots = KiteSpot.with_attached_photos.includes([:country]).take(4)
  end
end
