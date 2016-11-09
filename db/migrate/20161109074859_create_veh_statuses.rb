class CreateVehStatuses < ActiveRecord::Migration
  def change
    create_table :veh_statuses do |t|
      t.string :status

      t.timestamps null: false
    end
  end
end
