Rails.application.routes.draw do
  root to: 'home#index'
  get 'search', to: 'home#search_kits'
  devise_for :clients, controllers: { registrations: 'custom_registrations' }
  devise_for :admins
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

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
  resources :product_kits, only: %i[show]
  resource :cart, only: %i[show]
  resources :order_items, only: %i[create destroy]
  controller :orders do
    get '/checkout' => :checkout
    post '/order_confirm' => :confirm
    post '/order_payment' => :payment
  end
end
