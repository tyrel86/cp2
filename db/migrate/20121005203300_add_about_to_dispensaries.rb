class AddAboutToDispensaries < ActiveRecord::Migration
  def change
    add_column :dispensaries, :about, :text
  end
end
