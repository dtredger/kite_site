require 'administrate/base_dashboard'

class UserDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    name: Field::String,
    email: Field::String,
    role: EnumField.with_options(collection:User.roles),
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    provider: Field::String,
    latitude: Field::Number,
    longitude: Field::Number,
    location_map: Field::HasOne,
    # encrypted_password: Field::String,
    password: Field::Password,
    reset_password_token: Field::String,
    reset_password_sent_at: Field::DateTime,
    remember_created_at: Field::DateTime,
    allow_password_change: Field::Boolean,
    confirmation_token: Field::String,
    confirmed_at: Field::DateTime,
    confirmation_sent_at: Field::DateTime,
    unconfirmed_email: Field::String,
    failed_attempts: Field::Number,
    unlock_token: Field::String,
    locked_at: Field::DateTime,
    tokens: Field::String.with_options(searchable: false),
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    id
    name
    role
    email
    created_at
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    name
    email
    role
    created_at
    updated_at
    reset_password_sent_at
    remember_created_at
    latitude
    longitude
    location_map
    allow_password_change
    confirmation_sent_at
    confirmed_at
    unconfirmed_email
    failed_attempts
    locked_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    email
    name
    role
    latitude
    longitude
    allow_password_change
    confirmed_at
    unconfirmed_email
    failed_attempts
    locked_at
  ].freeze

  # COLLECTION_FILTERS
  # a hash that defines filters that can be used while searching via the search
  # field of the dashboard.
  #
  # For example to add an option to search for open resources by typing "open:"
  # in the search field:
  #
  COLLECTION_FILTERS = {
    admin: ->(resources) do
      resources.where(role: 'admin')
    end,

    new: ->(resources) do
      resources.where("created_at > ?", 1.week.ago)
    end

  }.freeze
  # COLLECTION_FILTERS = {}.freeze

  # Overwrite this method to customize how users are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(user)
    user.email
  end
end
