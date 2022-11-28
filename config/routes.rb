Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :portfolios
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :collections do
    resources :nfts, only: [:new, :create]
  end
  resources :nfts, only: [:index, :show, :edit, :update, :destroy]
  # Defines the root path route ("/")
  # root "articles#index"
end
