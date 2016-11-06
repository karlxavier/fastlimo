class AddColumnStatusIdToBooking < ActiveRecord::Migration
  def change
  	add_column :bookings, :status_id, :integer
  end
end
