Rails.application.routes.draw do
	# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

	resources :kite_spots
	resources :countries
	resources :location_maps


  root to: 'pages#index'

  devise_for :users

end
