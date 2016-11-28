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

  resources :rate_masters do
    resources :rate_details
    collection do
        get 'add_rate_details', :to => 'rate_masters#add_rate_details', :as => :add_rate_details
    end
  end

  resources :vehicles


  
  post 'incoming_sms', :to => 'bookings#incoming_sms', :as => :incoming_sms
  get 'to_cancel_booking', :to => 'bookings#to_cancel_booking', :as => :to_cancel_booking
  get 'cancel_booking/:book_id', :to => 'bookings#cancel_booking', :as => :cancel_booking
  patch 'execute_cancel/:book_id', :to => 'bookings#execute_cancel', :as => :execute_cancel
  get 'bookingmap/:book_id', :to => 'bookings#bookingmap', :as => :bookingmap
  get 'finished_bookings', :to => 'bookings#finished_bookings', :as => :finished_bookings
  get 'cancelled_bookings', :to => 'bookings#cancelled_bookings', :as => :cancelled_bookings
  get 'all_bookings', :to => 'bookings#all_bookings', :as => :all_bookings
  get 'exe_bookings/:book_id', :to => 'bookings#exe_bookings', :as => :exe_bookings
  patch 'confirm_execute/:book_id', :to => 'bookings#confirm_execute', :as => :confirm_execute
  get 'finish_booking/:book_id', :to => 'bookings#finish_booking', :as => :finish_booking
  root to: "bookings#dashboard"
end
