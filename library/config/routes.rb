Rails.application.routes.draw do
	
  resources	:sessions, only: [:new, :create, :destroy]

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  resources :users
  resources :books
  resources :categories

  root 'books#index'

  post 'favorite', to: "users#favorite", as: 'add_favorite'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
