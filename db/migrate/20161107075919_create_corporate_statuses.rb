class CreateCorporateStatuses < ActiveRecord::Migration
  def change
    create_table :corporate_statuses do |t|
      t.string :status

      t.timestamps null: false
    end
  end
end
