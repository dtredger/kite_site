# frozen_string_literal: true

class PagesController < ApplicationController
  skip_authorization_check

  def index
    @countries = Country.with_attached_photos.take(3)
    @kite_spots = KiteSpot.with_attached_photos.includes([:country]).take(4)
  end

  def contact
  end

end
