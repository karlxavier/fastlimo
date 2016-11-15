class AddColumnCancelledOnToBooking < ActiveRecord::Migration
  def change
  	add_column :bookings, :cancelled_on, :datetime
  end
end
