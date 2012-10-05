class AddFRequestToDispensaries < ActiveRecord::Migration
  def change
    add_column :dispensaries, :request_featured, :boolean
  end
end
