class AddColumnCancelReasonIdtoBooking < ActiveRecord::Migration
  def change
  	add_column :bookings, :cancel_reason_id, :integer
  end
end
