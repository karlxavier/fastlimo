class BookingsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_corporate

	def dashboard
		@bookings = Booking.all
		@drivers = Driver.all
		@corporates = Corporate.all
	end

	def index
		@bookings = @corporate.bookings.all.order('id desc')
	end

	def show
		@booking = Booking.find(params[:id])
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
			if @booking.booking_status_id == 2
				@driver = Driver.find(@booking.driver_id)
				@driver.driver_status_id = 2
				@driver.save
			end
			redirect_to all_bookings_path
		else
			render 'edit'
		end
	end

	def all_bookings		
		@bookings = Booking.where('booking_status_id IN (?)', [1,2]).order('id desc')
	end

	def exe_bookings				
		@booking = Booking.find(params[:book_id])
		@corporate = Corporate.find(@booking.corporate_id)
	end

	def finish_booking
		@booking = Booking.find(params[:book_id])
		@driver = Driver.find(@booking.driver_id)

		@booking.booking_status_id = 3
		@booking.finished_on  = Time.now
		@driver.driver_status_id = 1

		if @booking.save
			if @driver.save
				redirect_to all_bookings_path
			end
		end
	end

	def finished_bookings
		@bookings = Booking.where('booking_status_id IN (?)', 3).order('id desc')
	end

	def bookingmap
		@booking = Booking.find(params[:book_id])		
		respond_to do |format|
			format.js
		end
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
																			:executed_on, 
																			:execute_remarks,
																			:driver_id )
		end

		def set_corporate
			@corporate = Corporate.find(current_user.corporate_id)
		end

end
