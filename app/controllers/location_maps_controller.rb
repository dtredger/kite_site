# frozen_string_literal: true

class LocationMapsController < ApplicationController
  skip_authorization_check

  # GET /global-map
  def index
    @global_map_markers = LocationMap.leaflet_map_details
  end
end
