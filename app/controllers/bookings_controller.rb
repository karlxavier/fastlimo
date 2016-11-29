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
		@pickup = Location.find(@booking.from_name).name
		@dropoff = Location.find(@booking.to_name).name
	end

	def new
		@corporate
		@booking = @corporate.bookings.new
		# @rate_master = RateMaster.where("corporate_id IN ?", @corporate.id)
		# @payment_types = PaymentType.where("ID IN ?",@rate_master.payment_type_id)
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
			redirect_to all_bookings_path
		else
			render 'edit'
		end
	end

	def confirm_execute
		@booking = Booking.find(params[:book_id])

		if @booking.update_attributes(confirm_execute_params)
			if @booking.booking_status_id == 2
				@driver = Driver.find(@booking.driver_id)
				@driver.driver_status_id = 2
				@driver.save
			end			
			sms_reponse = "#{@booking.reference_no}: #{@booking.passenger_name}-#{@booking.telephone_no} FRM: #{@booking.from_name} TO: #{@booking.to_name}"
			send_text_to_driver(sms_reponse,@booking.driver.mobile_no)			
		else
			redirect_to exe_bookings_path(book_id: @booking.id)
		end
	end

	def incoming_sms
		incoming = Sanitize.clean(params[:From]).gsub(/^\+\d/, '')
    sms_input = params[:Body].downcase

    begin
    	@driver = Driver.where(mobile_no: incoming).first
    	@booking.where(booking_status_id: 2,driver_id: @driver.id).first
    	if @booking.present?
    		if sms_input == "1"
    			@booking.finish_booking!
    			send_text_to_driver("#{@booking.reference_no} is completed. Drive safely! - Maher",@driver.mobile_no)
    		end
    	else
    		send_text_to_driver("You dont have any active bookings now",@driver.mobile_no)
    	end

    rescue Exception => e
    	puts '******** ERROR ************'
    	puts "ERROR: #{e.message}"
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

		@booking.finished_by = current_user.fullname
		@booking.booking_status_id = 3
		@booking.finished_on  = Time.now
		@driver.driver_status_id = 1

		if @booking.save
			if @driver.save
				redirect_to all_bookings_path
			end
		else
			if @booking.errors.any?
    		@booking.errors.full_messages.each do |message|
      		puts message
    		end
  		end
  		redirect_to all_bookings_path
		end
	end

	def execute_cancel		
		@booking = Booking.find(params[:book_id])
		@booking.booking_status_id = 4

		if @booking.update_attributes(confirm_cancel_params)
			if @booking.driver_id.present?
				@driver = Driver.find(@booking.driver_id)
				@driver.driver_status_id = 1
				if @driver.save
					# redirect_to to_cancel_booking_path			
				end
			end
			redirect_to to_cancel_booking_path	
		else
			if @booking.errors.any?
    		@booking.errors.full_messages.each do |message|
      		puts message
    		end
  		end
			redirect_to cancel_booking_path(params[:book_id])
		end
	end

	def bookingmap
		@booking = Booking.find(params[:book_id])		
		respond_to do |format|
			format.js
		end
	end

	def finished_bookings
		@bookings = Booking.where('booking_status_id IN (?)', 3).order('id desc')
	end

	def cancelled_bookings
		@bookings = Booking.where('booking_status_id IN (?)', 4).order('id desc')
	end

	def to_cancel_booking
		@bookings = Booking.where('booking_status_id IN (?)', [1,2]).order('id desc')
	end

	def cancel_booking
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
																			:executed_on, 
																			:execute_remarks,
																			:driver_id,		
																			:executed_by,
																			:finished_by,
																			:cancelled_by,
																			:cancel_reason_id )
		end

		def confirm_execute_params
			params.require(:booking).permit(:driver_id, :price, :booking_status_id, :executed_on, :execute_remarks, :executed_by)
		end

		def confirm_cancel_params
			params.require(:booking).permit(:price, :booking_status_id, :cancelled_on, :execute_remarks, :cancelled_by, :cancel_reason_id)
		end

		def set_corporate
			@corporate = Corporate.find(current_user.corporate_id)
		end		

		def send_text_to_driver(message,to_whom)
			begin	
		    twilio_sid = ENV["TWILIO_ACCOUNT_SID"]
		    twilio_token = ENV["TWILIO_AUTH_TOKEN"]
		    twilio_phone_number = ENV["TWILIO_NUMBER"]

		    puts "SID: #{twilio_sid}"

		    @client = Twilio::REST::Client.new twilio_sid, twilio_token
		    @client.account.messages.create({
	        from: twilio_phone_number,
	        to: to_whom,
	        body: message
	      })	   
		    redirect_to all_bookings_path
  	rescue Exception => e
  		puts "ERROR: #{e.message}"
		end
	end

end
