CulturalGps::Application.routes.draw do
  devise_for :admins
  root 'events#index'

  resources :events
  resources :places
end
