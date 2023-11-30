require "administrate/base_dashboard"

class CountryDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    photos_attachments: Field::HasMany.with_options(class_name: "ActiveStorage::Attachment"),
    photos_blobs: Field::HasMany.with_options(class_name: "ActiveStorage::Blob"),
    kite_spots: Field::HasMany,
    location_map: Field::HasOne,
    rich_text_content: Field::HasOne,
    id: Field::Number,
    name: Field::Text,
    region: Field::Text,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    description: Field::Text,
    latitude: Field::Number.with_options(decimals: 2),
    longitude: Field::Number.with_options(decimals: 2),
    slug: Field::String,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
  photos_attachments
  photos_blobs
  kite_spots
  location_map
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
  photos_attachments
  photos_blobs
  kite_spots
  location_map
  rich_text_content
  id
  name
  region
  created_at
  updated_at
  description
  latitude
  longitude
  slug
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
  photos_attachments
  photos_blobs
  kite_spots
  location_map
  rich_text_content
  name
  region
  description
  latitude
  longitude
  slug
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
  # def display_resource(country)
  #   "Country ##{country.id}"
  # end
end
