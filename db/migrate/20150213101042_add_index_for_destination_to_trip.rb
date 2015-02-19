class AddIndexForDestinationToTrip < ActiveRecord::Migration
  def change
    add_index :trips, :destination
  end
end
