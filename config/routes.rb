Rails.application.routes.draw do
  resources :countries
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # root to: lambda { |x| [200, {"Content-Type" => "text/html"}, [content]] }

  root to: 'pages#index'

end
