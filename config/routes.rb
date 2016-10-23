Rails.application.routes.draw do
  root to: 'home#index', as: 'home'

  get 'home/index'

  resources :users do
    resource :call, module: :users
    post "twilio/voice", to: "twilio#voice"
    post "twilio/respond_to_homeless_voice", to: "twilio#respond_to_homeless_voice"
    get "twilio/voice", to: "twilio#voice"
  end

  resources :shelters
  resources :stays
  resources :history
end
