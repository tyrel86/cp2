class CreateAds < ActiveRecord::Migration
  def change
    create_table :ads do |t|
      t.string :name
      t.string :href
      t.integer :ad_type_id

      t.timestamps
    end
  end
end
