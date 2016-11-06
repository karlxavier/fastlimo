class RenameStatusToBookingStatInBookings < ActiveRecord::Migration
  def change
  	rename_column :bookings, :status_id, :booking_status_id
  end
end
