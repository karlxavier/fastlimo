class AddColumnExeRemarksToBooking < ActiveRecord::Migration
  def change
  	add_column :bookings, :execute_remarks, :text
  end
end
