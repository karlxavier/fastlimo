class CarType < ActiveRecord::Base
	has_many :bookings
	has_many :vehicles
end
