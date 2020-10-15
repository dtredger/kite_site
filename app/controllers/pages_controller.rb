# frozen_string_literal: true

class PagesController < ApplicationController
  def index
    @countries = Country.with_attached_photos.take(4)
    @kite_spots = KiteSpot.with_attached_photos.includes([:country]).take(4)
  end


  # TODO - N+1 for month_search queries
  def search
    name = search_params[:name]
    @months = search_params[:month].to_h.filter{ |key, val| val == '1' }.keys

    if name.present?
      name_countries = Country.name_search(name).includes(:kite_spots).to_a
      name_kitespots = KiteSpot.name_search(name).includes(:country).to_a
    end

    # TODO - month_search doesn't return ActiveRecord::Relation (so can't use .includes())
    if @months.any?
      month_countries = Country.month_search(@months)
      month_kitespots = KiteSpot.month_search(@months)
    end

    if name.present? & @months.any?
      @countries = (name_countries & month_countries)
      @kite_spots = (name_kitespots & month_kitespots)
    elsif name.present? & @months.empty?
      @countries = name_countries
      @kite_spots = name_kitespots
    elsif name.blank? & @months.any?
      @countries = month_countries
      @kite_spots = month_kitespots
    else
      @countries, @kite_spots = Country.none, KiteSpot.none
    end

    render action: :index
  end


  private

  def search_params
    all_months = %w[Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec]
    params.require(:search).permit(:name, month: all_months)
  end

end
