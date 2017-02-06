Rails.application.routes.draw do

  resources :favorites
  resources	:sessions, only: [:new, :create, :destroy]

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :books

  root 'books#index'

  resources :categories
  
  post 'add_favorites', to: 'favorites#create', as: 'add_favorite'
end
