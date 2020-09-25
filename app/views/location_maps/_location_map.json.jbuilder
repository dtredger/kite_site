# frozen_string_literal: true

json.extract! location_map, :id, :created_at, :updated_at
json.url location_map_url(location_map, format: :json)
