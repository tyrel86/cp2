class AddAttachmentPhotoToDispensaries < ActiveRecord::Migration
  def self.up
    change_table :dispensaries do |t|
      t.has_attached_file :photo
    end
  end

  def self.down
    drop_attached_file :dispensaries, :photo
  end
end
