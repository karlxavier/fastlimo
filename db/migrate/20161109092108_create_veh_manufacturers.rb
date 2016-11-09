class CreateVehManufacturers < ActiveRecord::Migration
  def change
    create_table :veh_manufacturers do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
