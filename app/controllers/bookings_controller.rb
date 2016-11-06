class BookingsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_corporate

	def index
	end

	def new
		@corporate
		@booking = Booking.new
		@car_types = CarType.all
		@payment_types = PaymentType.all
	end

	def update
	end

	private

		def booking_params
			params.require(:booking).permit(:book_date, 
																			:book_time, 
																			:car_type_id, 
																			:from_name, 
																			:from_lat, 
																			:from_lng, 
																			:to_name, 
																			:to_lat, 
																			:to_lng, 
																			:passenger_name, 
																			:telephone_no, 
																			:payment_type_id, 
																			:corporate_id, 
																			:booking_status_id, 
																			:remarks, 
																			:driver_id )
		end

		def set_corporate
			@corporate = Corporate.find(current_user.corporate_id)
		end

end
