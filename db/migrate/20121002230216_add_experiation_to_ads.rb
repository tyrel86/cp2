class AddExperiationToAds < ActiveRecord::Migration
  def change
    add_column :ads, :expiration, :date
  end
end
