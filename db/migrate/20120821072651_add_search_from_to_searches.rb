class AddSearchFromToSearches < ActiveRecord::Migration
  def change
    add_column :searches, :search_from, :string
  end
end
