class AddTidToTrips < ActiveRecord::Migration
  def change
    change_table(:trips) do |t|
      t.uuid :tid, null: false, default: "uuid_generate_v4()"  
    end

    add_index :trips, :tid, :unique => true
  end
end