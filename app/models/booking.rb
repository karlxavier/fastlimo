class Booking < ActiveRecord::Base
	belongs_to :car_type
	belongs_to :payment_type
	belongs_to :corporate
	belongs_to :booking_status
	belongs_to :driver
end
