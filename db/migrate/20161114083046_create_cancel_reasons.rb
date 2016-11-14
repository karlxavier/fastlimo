class CreateCancelReasons < ActiveRecord::Migration
  def change
    create_table :cancel_reasons do |t|
      t.string :reason

      t.timestamps null: false
    end
  end
end
