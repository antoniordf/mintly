Rails.application.routes.draw do
  devise_for :users
  root to: "portfolios#show" # "pages#home"
  resources :collections do
    resources :nfts
    resources :portfolio_collections, only: [:create]
  end
  resources :portfolio_collections, only: [:destroy]
  resources :portfolios, only: [:show]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
end
