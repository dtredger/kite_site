# frozen_string_literal: true

class LocationMapsController < ApplicationController
  # GET /global-map
  def index
    @location_maps = LocationMap.all
    @global_map_data = LocationMap.all_spots_map
  end
end
