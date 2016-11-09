class Vehicle < ActiveRecord::Base
	belongs_to :veh_manufacturer
	belongs_to :car_type
	belongs_to :veh_status
	belongs_to :driver
	before_create :set_vehicle_new

	validates :veh_model, :seat_capacity, :plate_no, :on_fleet_on, presence: true

	private

	def set_vehicle_new
		self.veh_status_id = 1
	end

end
