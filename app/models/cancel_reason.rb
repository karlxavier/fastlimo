class CancelReason < ActiveRecord::Base
	has_many :bookings
end
