class AddTypeToDispensaries < ActiveRecord::Migration
  def change
    add_column :dispensaries, :business_type, :integer
  end
end
