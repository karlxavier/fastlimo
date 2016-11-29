class ChangeColumnFromNameToIntegerInBooking < ActiveRecord::Migration
  def change
  	change_column :bookings, :from_name, 'integer USING CAST(from_name AS integer)'
  	change_column :bookings, :to_name, 'integer USING CAST(to_name AS integer)'
  end
end
