Rails.application.routes.draw do
  devise_for :clients
  devise_for :admins
  root to: 'home#index'
end
