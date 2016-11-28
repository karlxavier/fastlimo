class RateMastersController < ApplicationController
	before_action :authenticate_user!

	def index
		@RateMasters  = RateMaster.all
	end

	def new
		@rate_master = RateMaster.new
		# @rate_master.rate_details.new
		# @corporates = RateMaster.all.pluck(:coporate_id)
		if RateMaster.count == 0
			@corporates = Corporate.all
		else
			@corporates = Corporate.all.where('id NOT IN (?)',RateMaster.all.pluck(:coporate_id))
		end
	end

	def create
	end

	def edit
	end

	def update
	end

	def add_rate_details
		@rate_details = @rate_master.rate_details.build
	end

	private

		def def_master_params
			params.require(:rate_master).permit(:tname,:coporate_id,:payment_type_id,rate_details_attributes: [:id,:rate_master_id,:amount,:pickup,:dropoff])
		end
end
