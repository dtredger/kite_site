Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'  #, controllers: { sessions: 'api/sessions', token_validations: 'api/token_validations' }
	# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

	resources :kite_spots
	resources :countries

  get 'global-map', to: 'location_maps#index'

  # devise_for :users, controllers: { registrations: 'users/registrations' }

  get 'search', to: 'pages#search'


	root to: 'pages#index'

  namespace :api do
    namespace :v1 do
      resources :kite_spots, only: %i[index show]
      resources :countries, only: %i[index show]
    end
  end

  # ensure active_storage routes aren't caught in traditional routes catchall
  unless Rails.env.development?
    get '*all',
        to: redirect { |_, req| req.flash[:alert] = 'Requested Page not found'; '/' },
        constraints: ->(req) { req.path.exclude? 'rails/active_storage' }
  end
end
