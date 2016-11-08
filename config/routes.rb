Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations"}
  # devise_for :users
  
  resources :corporates do
    resources :bookings
    collection do
      get 'new_user'
    end
  end
  resources :drivers do
    member do
      get 'driver_history'
    end
  end

  get 'finished_bookings', :to => 'bookings#finished_bookings', :as => :finished_bookings
  get 'all_bookings', :to => 'bookings#all_bookings', :as => :all_bookings
  get 'exe_bookings/:book_id', :to => 'bookings#exe_bookings', :as => :exe_bookings
  get 'finish_booking/:book_id', :to => 'bookings#finish_booking', :as => :finish_booking
  root to: "bookings#dashboard"
end
