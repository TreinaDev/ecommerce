Rails.application.routes.draw do
  devise_for :clients
  devise_for :admins
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#index'

  namespace :admin do
    get '/dashboard', to: 'home#dashboard'
    resources :products, only: %i[index]
    resources :solar_plates, only: %i[new create show]
    resources :inversors, only: %i[new create show]
  end

  resources :carriers, only: %i[index show new create] do
    resources :carrier_options, only: %i[new create]
  end
  resources :carrier_options, only: %i[show edit update destroy]

  resource :cart, only: %i[show]
end
