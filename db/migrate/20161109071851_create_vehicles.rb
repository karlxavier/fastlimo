class CreateVehicles < ActiveRecord::Migration
  def change
    create_table :vehicles do |t|    	
    	t.string :veh_model
    	t.string :seat_capacity
    	t.string :plate_no
    	t.string :chassis_no
    	t.string :engine_no
    	t.date :on_fleet_on

    	t.integer :veh_manufacturer_id
    	t.integer :car_type_id 
    	t.integer :veh_status_id
    	t.integer :driver_id
      t.timestamps null: false
    end
  end
end
