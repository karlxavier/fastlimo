class CreateRateMasters < ActiveRecord::Migration
  def change
    create_table :rate_masters do |t|
      t.string :tname
      t.boolean :valid
      t.integer :coporate_id
      t.integer :payment_type_id
      
      t.timestamps null: false
    end
  end
end
