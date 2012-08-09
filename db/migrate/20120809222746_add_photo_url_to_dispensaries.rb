class AddPhotoUrlToDispensaries < ActiveRecord::Migration
  def change
    add_column :dispensaries, :photo_url, :string
  end
end
