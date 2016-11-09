class AddColumnWithVehicleToDriver < ActiveRecord::Migration
  def change
  	add_column :drivers, :with_vehicle, :boolean, default: false
  end
end
