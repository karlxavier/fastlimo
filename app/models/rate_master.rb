class RateMaster < ActiveRecord::Base
	belongs_to :coporate
	has_many :rate_details
	accepts_nested_attributes_for :rate_details

	validates :tname, presence: true
	validates_associated :rate_details
end
