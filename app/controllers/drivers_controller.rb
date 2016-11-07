class DriversController < ApplicationController
	before_action :authenticate_user!
	before_action :require_super_admin

	def index
		@drivers = Driver.all
	end

	def new
		@driver = Driver.new
	end

	def create
		@driver = Driver.new(driver_params)
		if @driver.save
			redirect_to drivers_path
		else
			render 'new'
		end
	end

	def edit
		@driver = Driver.find(params[:id])		
	end

	def update
		@driver = Driver.find(params[:id])		
		if @driver.update_attributes(driver_params)
			redirect_to drivers_path
		else
			render 'edit'
		end
	end

	private

		def driver_params
			params.require(:driver).permit(:name, :mobile_no, :driver_status_id, :remarks)
		end

		def require_super_admin
			unless current_user && current_user.super == true
	      flash[:error] = "You are not a super admin"
	      redirect_to root_path
	    end   
		end
end
