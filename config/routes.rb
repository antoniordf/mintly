Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :collections
  resources :portfolios, only: [:show] do
    resources :collections do
      resources :nfts
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
end
