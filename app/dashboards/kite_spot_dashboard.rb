require "administrate/base_dashboard"

class KiteSpotDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    country: Field::BelongsTo,
    taggings: Field::HasMany.with_options(class_name: '::ActsAsTaggableOn::Tagging'),
    base_tags: Field::HasMany.with_options(class_name: '::ActsAsTaggableOn::Tag'),
    month_tag_taggings: Field::HasMany.with_options(class_name: 'ActsAsTaggableOn::Tagging'),
    month_tags: Field::HasMany.with_options(class_name: 'ActsAsTaggableOn::Tag'),
    amenity_tag_taggings: Field::HasMany.with_options(class_name: 'ActsAsTaggableOn::Tagging'),
    amenity_tags: Field::HasMany.with_options(class_name: 'ActsAsTaggableOn::Tag'),
    photos_attachments: Field::ActiveStorage,
    # photos_blobs: Field::HasMany.with_options(class_name: 'ActiveStorage::Blob'),
    location_map: Field::HasOne,
    rich_text_content: Field::HasOne.with_options(class_name: 'ActionText::RichText'),
    id: Field::Number,
    name: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    description: Field::Text,
    # content: TrixField,
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
    name
    country
    created_at
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.

  # taggings
  # base_tags
  # month_tag_taggings
  # month_tags
  # amenity_tag_taggings
  # amenity_tags
  # rich_text_content
  # photos_blobs

  SHOW_PAGE_ATTRIBUTES = %i[
    country
    photos_attachments
    location_map
    id
    name
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

  # photos_blobs

  FORM_ATTRIBUTES = %i[
    country
    taggings
    base_tags
    month_tag_taggings
    month_tags
    amenity_tag_taggings
    amenity_tags
    photos_attachments

    location_map
    rich_text_content
    name
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

  # Overwrite this method to customize how kite spots are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(kite_spot)
    kite_spot.name
  end

  # https://github.com/Dreamersoul/administrate-field-active_storage
  # permitted for has_many_attached
  def permitted_attributes
    super + [:photos_attachments => []]
  end
end
