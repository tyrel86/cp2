class AddClicksShowsToAds < ActiveRecord::Migration
  def change
    add_column :ads, :clicks, :integer
    add_column :ads, :shows, :integer
  end
end
