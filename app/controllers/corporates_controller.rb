class CorporatesController < ApplicationController
	before_action :authenticate_user!
	before_action :require_super_admin

	def index
		@corporates = Corporate.all
	end

	def new
		@corporate = Corporate.new
	end

	def create
		@corporate = Corporate.new(corporate_params)
		if @corporate.save
			redirect_to corporates_path
		else
			render 'new'
		end
	end

	def edit
		@corporate = Corporate.find(params[:id])
	end

	def update
		@corporate = Corporate.find(params[:id])
		if @corporate.update_attributes(corporate_params)
			redirect_to corporates_path
		else
			render 'edit'
		end
	end

	def new_user	
		respond_to do |format|
			format.js
		end
	end

	private

		def corporate_params
			params.require(:corporate).permit(:name,
																				:address,
																				:telephone,
																				:account_no,
																				:corporate_status_id)
		end

		def require_super_admin
			unless current_user && current_user.super == true
	      flash[:error] = "You are not a super admin"
	      redirect_to root_path
	    end   
		end

end
