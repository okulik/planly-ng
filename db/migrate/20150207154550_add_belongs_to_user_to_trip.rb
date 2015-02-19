class AddBelongsToUserToTrip < ActiveRecord::Migration
  def change
    change_table(:trips) do |t|
      t.belongs_to :user, index: true  
    end
  end
end
