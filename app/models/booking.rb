class Booking < ActiveRecord::Base
	belongs_to :car_type
	belongs_to :payment_type
	belongs_to :corporate
	belongs_to :booking_status
	belongs_to :driver
  belongs_to :cancel_reason
	before_create :set_booking_new
	before_create :generate_ref_id

	validate :book_date_is_valid_datetime, on: :create
	validate :book_time_is_valid_time
  validate :book_date_cannot_be_in_the_past, on: :create
  validates :telephone_no, presence: true, numericality: true, length: { minimum: 9, maximum: 12 }, on: :create
	validates :passenger_name, :from_name, :to_name, :book_time, :book_date, presence: true, on: :create
  validates :price, presence: true, on: :update, if: :valid_execution?
  validates :driver_id, presence: true, if: :valid_to_execute?

	def book_date_is_valid_datetime	
    # errors.add(:book_date, 'must be a valid datetime') if ((DateTime.parse(book_date.strftime "%m/%d/%Y") rescue ArgumentError) == ArgumentError)
  end

  def book_time_is_valid_time
  	# errors.add(:book_time, 'must be a valid time') if ((Time.parse(book_time.strftime "%I:%M%p") rescue ArgumentError) == ArgumentError)
  end

  def set_booking_new
  	self.booking_status_id = 1
  end

  def book_date_cannot_be_in_the_past
    if book_date.present? && book_date < Date.today
      errors.add(:book_date, "can't be in the past")
    end
  end

  def valid_execution?
    changed.include?("booking_status_id")
    # changed.include?("booking_status_id") && !executed_on.blank?
  end

  def finish_booking!
    self.update(booking_status_id: 3)
  end

  def valid_to_execute?
    booking_status_id == 2
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
