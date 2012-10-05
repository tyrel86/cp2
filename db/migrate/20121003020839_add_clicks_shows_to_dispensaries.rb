class AddClicksShowsToDispensaries < ActiveRecord::Migration
  def change
    add_column :dispensaries, :clicks, :integer
    add_column :dispensaries, :featured_clicks, :integer
    add_column :dispensaries, :featured_shows, :integer
    add_column :dispensaries, :shows, :integer
  end
end
