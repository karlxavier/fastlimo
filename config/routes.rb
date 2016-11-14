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

  resources :vehicles

  get 'to_cancel_booking', :to => 'bookings#to_cancel_booking', :as => :to_cancel_booking
  get 'cancel_booking/:book_id', :to => 'bookings#cancel_booking', :as => :cancel_booking
  get 'execute_cancel/:book_id', :to => 'bookings#execute_cancel', :as => :execute_cancel
  get 'bookingmap/:book_id', :to => 'bookings#bookingmap', :as => :bookingmap
  get 'finished_bookings', :to => 'bookings#finished_bookings', :as => :finished_bookings
  get 'all_bookings', :to => 'bookings#all_bookings', :as => :all_bookings
  get 'exe_bookings/:book_id', :to => 'bookings#exe_bookings', :as => :exe_bookings
  patch 'confirm_execute/:book_id', :to => 'bookings#confirm_execute', :as => :confirm_execute
  get 'finish_booking/:book_id', :to => 'bookings#finish_booking', :as => :finish_booking
  root to: "bookings#dashboard"
end
