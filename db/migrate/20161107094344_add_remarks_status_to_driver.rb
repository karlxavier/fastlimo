class AddRemarksStatusToDriver < ActiveRecord::Migration
  def change
  	add_column :drivers, :driver_status_id, :integer
  	add_column :drivers, :remarks, :text
  end
end
