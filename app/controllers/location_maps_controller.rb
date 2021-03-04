# frozen_string_literal: true

class LocationMapsController < ApplicationController
  skip_authorization_check
  include Regionable

  # GET /global-map
  def index
    @global_map_details = LocationMap.leaflet_map_details(:all)
  end

  # GET/regions?name='north-america'
  def show
    name_slug = location_map_params[:name] || ''
    @region_details = region_details(name_slug)

    @region_details[:map_details] = LocationMap.leaflet_map_details(
        @region_details[:countries] + @region_details[:kite_spots],
        @region_details[:lat_lon_arr])

    # TODO - only kitespots are paginated: blend kitespot and country models? or separate tabs?
    @region_details[:kite_spots] = Kaminari.paginate_array(@region_details[:kite_spots]).page(params[:page]).per(12)
    @region_details
  end


  private

  def location_map_params
    params.permit(:name)
  end
end
