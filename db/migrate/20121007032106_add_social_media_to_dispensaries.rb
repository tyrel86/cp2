class AddSocialMediaToDispensaries < ActiveRecord::Migration
  def change
    add_column :dispensaries, :twitter, :string
    add_column :dispensaries, :facebook, :string
  end
end
