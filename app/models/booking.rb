class Booking < ActiveRecord::Base
	belongs_to :car_type
	belongs_to :payment_type
	belongs_to :corporate
	belongs_to :booking_status
	belongs_to :driver
	before_create :set_booking_new
	before_create :generate_ref_id
  before_save :geocode_endpoints

	validate :book_date_is_valid_datetime
	validate :book_time_is_valid_time
	validates :passenger_name, :from_name, :to_name, :book_time, :book_date, presence: true

	def book_date_is_valid_datetime	
    errors.add(:book_date, 'must be a valid datetime') if ((DateTime.parse(book_date.strftime "%m/%d/%Y") rescue ArgumentError) == ArgumentError)
  end

  def book_time_is_valid_time
  	# errors.add(:book_time, 'must be a valid time') if ((Time.parse(book_time.strftime "%I:%M%p") rescue ArgumentError) == ArgumentError)
  end

  def set_booking_new
  	self.booking_status_id = 1
  end
 
  def geocode_endpoints
    if from_name_changed?
      geocoded = Geocoder.search(from_name).first
      if geocoded
        self.from_lat = geocoded.latitude
        self.from_lng = geocoded.longitude
      end
    end
    # Repeat for destination
    if to_name_changed?
      geocoded = Geocoder.search(to_name).first
      if geocoded
        self.to_lat = geocoded.latitude
        self.to_lng = geocoded.longitude
      end
    end
  end

  def generate_ref_id
    reference_no = 'BK'
    if Booking.count == 0
      self.reference_no = "#{reference_no}-00001"
    else
      last_reference_no = Booking.last.reference_no
      number = last_reference_no.split('-')[1].to_i
      number += 1
      self.reference_no = reference_no + '-' + "%05d" % number
    end
  end

end
