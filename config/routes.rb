Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :collections do
    resources :nfts
    resources :portfolio_collections, only: [:create]
  end
  resources :portfolio_collections, only: [:destroy]
  resources :portfolios, only: [:show]
  get "logout", to: "pages#logout", as: :logout
end
