module DeviseMacros
	include Warden::Test::Helpers

	# def login_advertiser
	# 	let(:advertiser) { FactoryGirl.create(:advertiser) }
	#
	# 	before(:each) do
	# 		@request.env["devise.mapping"] = Devise.mappings[:advertiser]
	# 		sign_in advertiser
	# 	end
	# end
	#
	# def logout_advertiser
	# 	let(:advertiser) { FactoryGirl.create(:advertiser) }
	#
	# 	before(:each) do
	# 		@request.env["devise.mapping"] = Devise.mappings[:advertiser]
	# 		sign_out advertiser
	# 	end
	# end

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
