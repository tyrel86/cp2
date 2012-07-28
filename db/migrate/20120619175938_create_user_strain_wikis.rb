class CreateUserStrainWikis < ActiveRecord::Migration
  def change
    create_table :user_strain_wikis do |t|

      t.timestamps
    end
  end
end
