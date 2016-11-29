class RateMaster < ActiveRecord::Base
	belongs_to :coporate
	belongs_to :payment_type
	has_many :rate_details
	accepts_nested_attributes_for :rate_details

	validates :tname, presence: true
	validates_associated :rate_details
end
