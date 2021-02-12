Rails.application.routes.draw do
  namespace :admin do
    resources :users
    resources :kite_spots
    resources :countries
    resources :location_maps
    root to: 'users#index'
  end

  authenticate :user, -> (user) { user.admin? } do
    mount PgHero::Engine, at: 'pghero'
  end

  devise_for :users, controllers: { registrations: 'users/registrations' }
  get 'profile',          to: 'users/profiles#index'

  resources :kite_spots, path: '/kite-spots'
  resources :countries

  get 'global-map',       to: 'location_maps#index'
  get 'region',           to: 'location_maps#show'

  get 'search',           to: 'searches#index'
  get 'search/advanced',  to: 'searches#show'

  get 'contact',          to: 'pages#contact'
  get 'faq',              to: 'pages#faq'
  root                    to: 'pages#index'


  # TODO - disable API for now
  # mount_devise_token_auth_for 'User', at: 'auth'
  #, controllers: { sessions: 'api/sessions', token_validations: 'api/token_validations' }
  # namespace :api do
  #   namespace :v1 do
  #     resources :kite_spots, only: %i[index show]
  #     resources :countries, only: %i[index show]
  #   end
  # end


  # ensure active_storage routes aren't caught in traditional routes catchall
  unless Rails.env.development?
    get '*all',
        to: redirect { |_, req| req.flash[:alert] = 'Requested Page not found'; '/' },
        constraints: ->(req) { req.path.exclude? 'rails/active_storage' }
  end
end
