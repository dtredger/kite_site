# frozen_string_literal: true

require 'administrate/base_dashboard'

class KiteSpotDashboard < Administrate::BaseDashboard
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
    description: Field::Text,
    content: TrixField,
    latitude: Field::Number.with_options(decimals: 2),
    longitude: Field::Number.with_options(decimals: 2),
    country: Field::BelongsTo.with_options(
      searchable: true,
      searchable_fields: ['name']
    ),
    location_map: Field::HasOne,
    photos: Field::ActiveStorage.with_options(
      destroy_url: proc do |_namespace, resource, photo|
        [:admin_destroy_photo, { model: :KiteSpot, resource: resource, photo_id: photo.id }]
      end
    ),
    # taggings: Field::HasMany.with_options(class_name: '::ActsAsTaggableOn::Tagging'),
    # base_tags: Field::HasMany.with_options(class_name: '::ActsAsTaggableOn::Tag'),
    # month_tag_taggings: Field::HasMany.with_options(class_name: 'ActsAsTaggableOn::Tagging'),
    # month_tags: Field::HasMany.with_options(class_name: 'ActsAsTaggableOn::Tag'),
    month_tags: Field::Tag.with_options(class_name: 'ActsAsTaggableOn::Tag'), #, attribute_name: :title),
    # amenity_tag_taggings: Field::HasMany.with_options(class_name: 'ActsAsTaggableOn::Tagging'),
    # amenity_tags: Field::HasMany.with_options(class_name: 'ActsAsTaggableOn::Tag'),
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
    name
    country
    created_at
    updated_at
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.

  # taggings
  # base_tags
  # month_tag_taggings
  # month_tags
  # amenity_tag_taggings
  # amenity_tags
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    name
    slug
    description
    content
    country
    latitude
    longitude
    month_tags
    photos
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.

  # photos_blobs
  # photos

  # taggings
  # base_tags
  # month_tag_taggings
  # month_tags
  # amenity_tag_taggings
  # amenity_tags

  FORM_ATTRIBUTES = %i[
    name
    description
    content
    country
    latitude
    longitude
    month_tags
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
  COLLECTION_FILTERS = {
    # TODO - ActiveRecord::StatementInvalid in Admin::KiteSpots#index
    # (PG::AmbiguousColumn: ERROR:  column reference "updated_at" is ambiguous)
    # new: ->(resources) do
    #   resources.where("updated_at > ?", 1.week.ago)
    # end
  }.freeze

  # Overwrite this method to customize how kite spots are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(kite_spot)
    kite_spot.name
  end

  # https://github.com/Dreamersoul/administrate-field-active_storage
  # permitted for has_many_attached
  def permitted_attributes
    super + [:photos => []] + [:month_tags => []]
  end
end
