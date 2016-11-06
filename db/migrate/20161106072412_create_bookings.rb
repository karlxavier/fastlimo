class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.date :book_date
      t.time :book_time
      t.integer :car_type_id
      t.string :from_name
      t.float :from_lat
      t.float :from_lng
      t.string :to_name
      t.float :to_lat
      t.float :to_lng
      t.string :passenger_name
      t.string :telephone_no
      t.string :ordered_by
      t.integer :payment_type_id
      t.integer :corporate_id

      t.timestamps null: false
    end
  end
end
