Rails.application.routes.draw do
  resources :flights, only: [:index]
  resources :bookings, only: [:new, :show]
  
  root "flights#index"
end
