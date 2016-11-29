class PaymentType < ActiveRecord::Base
	has_many :bookings
	has_many :rate_masters
end
