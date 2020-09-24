# frozen_string_literal: true

module DeviseMacros
  include Warden::Test::Helpers

  def login_user
    let(:user) { create(:user) }

    before do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in user
    end
  end

  def logout_user
    let(:user) { create(:user) }

    before do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_out user
    end
  end

  def sign_in(resource_or_scope, resource = nil)
    resource ||= resource_or_scope
    scope = Devise::Mapping.find_scope!(resource_or_scope)
    login_as(resource, scope: scope)
  end

  def sign_out(resource_or_scope)
    scope = Devise::Mapping.find_scope!(resource_or_scope)
    logout(scope)
  end
end
