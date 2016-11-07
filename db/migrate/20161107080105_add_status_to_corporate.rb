class AddStatusToCorporate < ActiveRecord::Migration
  def change
  	add_column :corporates, :corporate_status_id, :integer
  end
end
