Rails.application.routes.draw do

get '/', to: 'gossips#index'
get 'index', to: 'gossips#index', as: 'gossip'
get 'team', to: 'pages#team'
get 'contact', to: 'pages#contact'
get 'bienvenue/:first_name', to: 'pages#bienvenue', as: "bienvenue"
get '/gossip', to: 'gossips#gossip'
resources :gossips
resources :users
resources :cities
resources :comments
resources :sessions, only: [:new, :create, :destroy]
resources :gossips
end
