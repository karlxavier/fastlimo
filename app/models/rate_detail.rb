class RateDetail < ActiveRecord::Base
	belongs_to :rate_master

	validates :amount, presence: true, numericality: true
	validates :pickup, :dropoff, presence: true
end
