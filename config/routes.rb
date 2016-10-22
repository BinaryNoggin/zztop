Rails.application.routes.draw do
  root to: 'home#index', as: 'home'

  get 'home/index'

  resources :users
  resources :shelters
  resources :stays

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
