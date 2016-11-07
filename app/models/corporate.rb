class Corporate < ActiveRecord::Base
	has_many :bookings
	belongs_to :corporate_status

	validates :name, :address, presence: true
end
