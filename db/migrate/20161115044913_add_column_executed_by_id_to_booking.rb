class AddColumnExecutedByIdToBooking < ActiveRecord::Migration
  def change
  	add_column :bookings, :executed_by, :string
  	add_column :bookings, :finished_by, :string
  	add_column :bookings, :cancelled_by, :string
  end
end
