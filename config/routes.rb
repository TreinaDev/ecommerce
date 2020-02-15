Rails.application.routes.draw do
  devise_for :clients, controllers: { registrations: 'custom_registrations' }
  devise_for :admins
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#index'

  namespace :admin do
    get '/dashboard', to: 'home#dashboard'
    resources :products, only: %i[index]
    resources :solar_plates, only: %i[new create show]
    resources :inversors, only: %i[new create show]
    resources :product_kits, only: %i[index new create show] do
      resources :kit_items, only: %i[new create]
    end
  end

  resources :product_kits, only: %i[index show]
  resources :carriers, only: %i[index show new create]
  resource :cart, only: %i[show]
end
