Rails.application.routes.draw do
  resources :flights, only: :show
  resources :passengers, only: :show
  resources :flight_passengers, only: :create
end
