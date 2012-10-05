class CreateHoursOfOperations < ActiveRecord::Migration
  def change
    create_table :hours_of_operations do |t|
      t.time :mo_start
      t.time :mo_end
      t.time :tu_start
      t.time :tu_end
      t.time :we_start
      t.time :we_end
      t.time :th_start
      t.time :th_end
      t.time :fr_start
      t.time :fr_end
      t.time :sa_start
      t.time :sa_end
      t.time :su_start
      t.time :su_end
      t.integer :dispensary_id

      t.timestamps
    end
  end
end
