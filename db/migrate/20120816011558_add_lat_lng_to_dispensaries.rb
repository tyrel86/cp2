class AddLatLngToDispensaries < ActiveRecord::Migration
  def change
    add_column :dispensaries, :lat, :float
    add_column :dispensaries, :lng, :float
  end
end
