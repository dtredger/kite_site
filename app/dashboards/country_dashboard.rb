# frozen_string_literal: true

require 'administrate/base_dashboard'

class CountryDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    name: Field::String,
    slug: Field::String,
    region: EnumField.with_options(collection: Country.regions),
    description: Field::Text,
    language: EnumField.with_options(collection: Country.languages),
    content: TrixField,
    latitude: Field::Number.with_options(decimals: 2),
    longitude: Field::Number.with_options(decimals: 2),
    location_map: Field::HasOne,
    kite_spots: Field::HasMany.with_options(
      searchable: true,
      searchable_fields: ['name']
    ),
    photos: Field::ActiveStorage.with_options(
      destroy_url: proc do |_namespace, resource, photo|
        [:admin_destroy_photo, { model: :Country, resource: resource, photo_id: photo.id }]
      end
    ),
    created_at: Field::DateTime.with_options(
      format: '%b %d, %Y'
    ),
    updated_at: Field::DateTime.with_options(
      format: '%b %d, %Y'
    )
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    id
    name
    kite_spots
    created_at
    updated_at
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    name
    slug
    region
    description
    language
    content
    latitude
    longitude
    kite_spots
    photos
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    name
    region
    description
    language
    content
    latitude
    longitude
    photos
  ].freeze

  # COLLECTION_FILTERS
  # a hash that defines filters that can be used while searching via the search
  # field of the dashboard.
  #
  # For example to add an option to search for open resources by typing "open:"
  # in the search field:
  #
  #   COLLECTION_FILTERS = {
  #     open: ->(resources) { resources.where(open: true) }
  #   }.freeze
  COLLECTION_FILTERS = {}.freeze

  # Overwrite this method to customize how countries are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(country)
    country.name
  end

  def permitted_attributes
    super + [photos: []]
  end
end
