class AddRemarksToBooking < ActiveRecord::Migration
  def change
  	add_column :bookings, :remarks, :text
  	add_column :bookings, :driver_id, :integer
  end
end
