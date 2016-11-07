class BookingsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_corporate

	def index
		@bookings = @corporate.bookings.all
	end

	def new
		@corporate
		@booking = @corporate.bookings.new
	end

	def create
		@booking = @corporate.bookings.new(booking_params)

			if @booking.save
				redirect_to root_path
			else
				render 'new'
			end
	end

	def edit
		@booking = Booking.find(params[:id])
	end

	def update
		@booking = Booking.find(params[:id])

		if @booking.update_attributes(booking_params)
			redirect_to root_path
		else
			render 'edit'
		end
	end

	def all_bookings		
		@bookings = Booking.all
	end

	def exe_bookings		
		@booking = Booking.find(params[:book_id])
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
