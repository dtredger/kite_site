# frozen_string_literal: true

class SearchesController < ApplicationController
  skip_authorization_check
  include Searchable


  def index
    # TODO - location not used
    results = name_loc_cat_search(basic_search_params)

    @countries = results[:countries] || []
    @countries = Kaminari.paginate_array(@countries).page(params[:page]).per(10)
    @kite_spots = results[:kite_spots] || []
    @kite_spots = Kaminari.paginate_array(@kite_spots).page(params[:page]).per(10)
    @map_markers = get_location_markers(results)
    render template: 'searches/index'
  end

  def show
    @countries = []
    @kite_spots = []
    @map_markers = []
    advanced_search(advanced_search_params) if params[:search]
    @countries = Kaminari.paginate_array(@countries).page(params[:page]).per(10)
    @kite_spots = Kaminari.paginate_array(@kite_spots).page(params[:page]).per(10)
    render template: 'searches/index'
  end


  private

  def basic_search_params
    params.require(:search).permit(:name, :location, :category)
  end

  def advanced_search_params
    params.require(:search).permit(:name, :distance, months: [], regions: [], amenities: [], languages: [])
  end

  def get_location_markers(results)
    countries = results[:countries] || []
    kite_spots = results[:kite_spots] || []
    LocationMap.leaflet_map_details(countries + kite_spots, map_center=[40, 0])
  end



end
