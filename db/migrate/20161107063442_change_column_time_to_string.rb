class ChangeColumnTimeToString < ActiveRecord::Migration
  def change
  	change_column :bookings, :book_time, :string
  end
end
