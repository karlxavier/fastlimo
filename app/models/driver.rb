class Driver < ActiveRecord::Base
	has_many :bookings
	belongs_to :driver_status
end
