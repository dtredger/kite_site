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
require 'rails_helper'

RSpec.describe User, type: :model do
  let(:admin) { create(:admin) }
  let(:user) { create(:user) }

  describe 'callbacks' do
    it 'creates associated location_map' do
      new_user = User.create(email: 'test@email.com', password: '123123123')
      expect(new_user.location_map).to be_a(LocationMap)
    end
  end

  context 'methods' do
    describe 'favorites' do
      let(:kite_spot) { create(:kite_spot) }

      it 'saves favorites' do
        expect  do
          user.favorite(kite_spot)
        end.to change(user.favorites, :count).by(1)
      end
    end
  end

  context 'permissions' do
    it 'sets admin email to admin' do
      new_admin = user
      new_admin.update(role: 'admin')
      expect(new_admin.admin?).to be(true)
    end

    it 'does not set others to admin' do
      expect(user.admin?).to be(false)
    end
  end

  context 'distance_calculable' do
    describe '#haversine_distance' do
      it 'calculates distance to country' do
        user = create(:user, latitude: 0, longitude: 0)
        country = create(:country, latitude: 10, longitude: 10)
        expect(user.haversine_distance(country)).to eq(1569)
      end

      it 'calculates distance to points' do
        user = create(:user, latitude: 0, longitude: 0)
        points = { latitude: 20, longitude: 20 }
        expect(user.haversine_distance(points)).to eq(3112)
      end

      it 'gives nil for bad coordinates' do
        user = create(:user, latitude: 0, longitude: 0)
        points = { latitude: nil, longitude: '' }
        expect(user.haversine_distance(points)).to eq(nil)
      end
    end
  end
end
