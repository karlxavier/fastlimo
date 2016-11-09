class VehiclesController < ApplicationController
	# before_action :authenticate_user!

	def index
		@vehicles = Vehicle.all
	end

	def show
	end

	def new
		@vehicle = Vehicle.new
	end

	def create
		@vehicle = Vehicle.new(vehicle_params)
		if @vehicle.save
			redirect_to vehicles_path
		else
			render 'new'
		end
	end

	def edit
	end

	def update
	end

	private

		def vehicle_params
			params.require(:vehicle).permit(:veh_model,
																			:seat_capacity,
																			:plate_no,
																			:chassis_no,
																			:engine_no,
																			:on_fleet_on,
																			:veh_manufacturer_id,
																			:car_type_id,
																			:veh_status_id,
																			:driver_id)
		end

end
