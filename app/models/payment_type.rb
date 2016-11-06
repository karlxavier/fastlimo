class PaymentType < ActiveRecord::Base
	has_many :bookings
end
