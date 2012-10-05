class AddFExperationToDispensaries < ActiveRecord::Migration
  def change
    add_column :dispensaries, :expiration, :date
  end
end
