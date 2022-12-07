Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :collections do
    resources :nfts, except: [:index]
    resources :portfolio_collections, only: [:create]
  end
  resources :portfolio_collections, only: [:destroy]
  resources :portfolios, only: [:show]
  resources :nfts, only: [:index]
  get "/home", to: 'pages#home', as: :home
end
