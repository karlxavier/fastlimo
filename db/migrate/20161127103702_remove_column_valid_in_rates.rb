class RemoveColumnValidInRates < ActiveRecord::Migration
  def change
  	remove_column :rate_masters, :valid
  end
end
