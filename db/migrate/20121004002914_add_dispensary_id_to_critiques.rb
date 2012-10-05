class AddDispensaryIdToCritiques < ActiveRecord::Migration
  def change
    add_column :critiques, :dispensary_id, :integer
  end
end
