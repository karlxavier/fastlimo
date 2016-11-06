class CreateCorporates < ActiveRecord::Migration
  def change
    create_table :corporates do |t|
      t.string :name
      t.string :address
      t.string :telephone
      t.string :account_no
      t.integer :status

      t.timestamps null: false
    end
  end
end
