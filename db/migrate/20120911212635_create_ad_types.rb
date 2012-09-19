class CreateAdTypes < ActiveRecord::Migration
  def change
    create_table :ad_types do |t|
      t.string :name
      t.integer :width
      t.integer :height

      t.timestamps
    end
  end
end
