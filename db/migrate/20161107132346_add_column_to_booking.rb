class AddColumnToBooking < ActiveRecord::Migration
  def change
  	add_column :bookings, :executed_on, :datetime
  	add_column :bookings, :finished_on, :datetime
  end
end
