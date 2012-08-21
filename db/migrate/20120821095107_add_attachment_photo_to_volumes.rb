class AddAttachmentPhotoToVolumes < ActiveRecord::Migration
  def self.up
    change_table :volumes do |t|
      t.has_attached_file :photo
    end
  end

  def self.down
    drop_attached_file :volumes, :photo
  end
end
