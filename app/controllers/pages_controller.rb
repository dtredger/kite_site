# frozen_string_literal: true

class PagesController < ApplicationController
  skip_authorization_check

  # TODO - including rich-text on card (and tags) requires including them for card display
  def index
    @countries = Country.with_attached_photos.shuffle.take(3)
    @kite_spots = KiteSpot.with_attached_photos.includes([:country, :rich_text_content, :taggings]).shuffle.take(4)
  end

  def contact
  end

  def faq
  end

end