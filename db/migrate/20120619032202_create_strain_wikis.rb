class CreateStrainWikis < ActiveRecord::Migration
  def change
    create_table :strain_wikis do |t|

      t.timestamps
    end
  end
end
