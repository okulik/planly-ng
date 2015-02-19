class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.string :destination
      t.date :start_date
      t.date :end_date
      t.text :comment
      t.timestamps null: false
    end

    add_index :trips, :start_date
    add_index :trips, :end_date
  end
end