# frozen_string_literal: true

# methods for logging-in for request & system specs
module DeviseMacros
  def log_in_user
    let(:user) { create(:user) }
    before { sign_in user }
  end

  def log_out_user
    let(:user) { create(:user) }
    before { sign_out user }
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
