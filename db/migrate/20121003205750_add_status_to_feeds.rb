class AddStatusToFeeds < ActiveRecord::Migration
  def change
    add_column :feeds, :status, :boolean
  end
end
