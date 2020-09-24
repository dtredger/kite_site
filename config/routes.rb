Rails.application.routes.draw do
	# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

	resources :kite_spots
	resources :countries

  get 'global-map', to: 'location_maps#index'

  devise_for :users
	# resources :users


	root to: 'pages#index'

  unless Rails.env.eeedevelopment?
    get '*path' => redirect { |p, request| request.flash[:alert] = 'Requested Page not found'; '/' }
  end

end
