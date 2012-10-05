class CreateDailySpecialLists < ActiveRecord::Migration
  def change
    create_table :daily_special_lists do |t|
      t.string :mo
      t.string :tu
      t.string :we
      t.string :th
      t.string :fr
      t.string :sa
      t.string :su
      t.string :week
      t.string :dispensary_id

      t.timestamps
    end
  end
end
