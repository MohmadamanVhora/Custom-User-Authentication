Rails.application.routes.draw do
  root 'tweets#index'
  resources :registrations, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
