Rails.application.routes.draw do
  devise_for :users
  
  resources :corporates do
    resources :bookings
  end

  root to: "bookings#index"
end
