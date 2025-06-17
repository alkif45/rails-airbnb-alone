Rails.application.routes.draw do
  devise_for :users
  resources :users, only: %i[show]
  root to: "pages#home"
  resources :flats, only: %i[index show new create] do
    resources :bookings, only: %i[new create]
  end
  resources :bookings, only: %i[index]

  get "up" => "rails/health#show", as: :rails_health_check
end
