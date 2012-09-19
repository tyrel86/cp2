class AddStuffToAds < ActiveRecord::Migration
  def change
    add_column :ads, :confirmed, :boolean
    add_column :ads, :user_id, :integer
  end
end
