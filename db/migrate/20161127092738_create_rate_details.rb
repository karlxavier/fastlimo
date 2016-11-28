class CreateRateDetails < ActiveRecord::Migration
  def change
    create_table :rate_details do |t|
      t.integer :rate_master_id
      t.decimal :amount, :precision => 8, :scale => 2
      t.string :pickup
      t.string :dropoff

      t.timestamps null: false
    end
  end
end
