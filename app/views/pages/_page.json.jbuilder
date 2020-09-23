# frozen_string_literal: true

json.extract! page, :id, :created_at, :updated_at
json.url page_url(page, format: :json)
