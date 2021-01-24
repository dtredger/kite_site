# frozen_string_literal: true

class LocationMapsController < ApplicationController
  skip_authorization_check

  # GET /global-map
  def index
    @global_map_data = LocationMap.all_spots_map
  end
end
