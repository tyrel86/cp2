class AddClicksToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :clicks, :integer
  end
end
