# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  allow_password_change  :boolean          default(FALSE)
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  failed_attempts        :integer          default(0), not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  latitude               :float
#  locked_at              :datetime
#  longitude              :float
#  name                   :string
#  provider               :string           default("email"), not null
#  region                 :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :integer
#  sign_in_count          :integer          default(0), not null
#  tokens                 :json
#  unconfirmed_email      :string
#  unlock_token           :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_unlock_token          (unlock_token) UNIQUE
#
class User < ApplicationRecord

  include DistanceCalculable

  has_one :location_map, as: :record, dependent: :destroy
  acts_as_favoritor

  validates_uniqueness_of :email
  # disable token auth (for api)for now
  # include DeviseTokenAuth::Concerns::User
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable #,
         # :confirmable,
         # :lockable,
         # :timeoutable,
         # :trackable
         # :omniauthable

  # TODO - after_save will happen after updates!
  after_create -> { create_location_map unless location_maps.any? }

  enum role: %i[banned basic author moderator admin]

  # https://github.com/CanCanCommunity/cancancan/wiki/Role-Based-Authorization
  def admin?
    return true if role == 'admin'
    false
  end

  def coordinates?
    latitude && longitude
  end

  def slug
    name
  end

  def location
    ''
  end

  def profile_picture
    # 'profile_pics/cat_sad'
    'profile_pics/oinky_pig'
    # 'profile_pics/skinny_boy'
    # 'profile_pics/racoon'
    # 'profile_pics/pingu_noot'
    # 'profile_pics/rigby_redemption'
    # 'profile_pics/peeposhortonagoose'
    # 'profile_pics/spagett'
    # 'profile_pics/snrub'
  end

  def profile_text
    ''
  end


  def kite_spots_by_distance
    @spots_distances ||= {}
    KiteSpot.all.each do |k|
      @spots_distances[k.slug] = haversine_distance(k)
    end
    @spots_distances.sort_by { |_name, distance| distance }
  end

  def closest_5_kite_spots
    @closest_5_kite_spots ||= begin
      spots = []
      kite_spots_by_distance[0..4].each do |spot|
        spots << KiteSpot.find_by(slug: spot[0])
      end
      spots
    end
  end

  def favorite_kite_spots
    kite_faves = favorites_by_type('KiteSpot')
    KiteSpot.find(kite_faves.map(&:favoritable_id))
  end

  def favorite_countries
    country_faves = favorites_by_type('Country')
    Country.find(country_faves.map(&:favoritable_id))
  end

end
