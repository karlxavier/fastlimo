class Corporate < ActiveRecord::Base
	has_many :bookings
	has_many :rate_masters
	belongs_to :corporate_status

	validates :name, :address, presence: true
end
