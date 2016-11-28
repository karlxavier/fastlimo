class AlterColumnToLocationMaster < ActiveRecord::Migration
  def change  	
    change_column :rate_details, :pickup, 'integer USING CAST(pickup AS integer)'
    change_column :rate_details, :dropoff, 'integer USING CAST(dropoff AS integer)'
  end
end
