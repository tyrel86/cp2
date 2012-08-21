class AddAttachmentPhotoToCritiques < ActiveRecord::Migration
  def self.up
    change_table :critiques do |t|
      t.has_attached_file :photo
    end
  end

  def self.down
    drop_attached_file :critiques, :photo
  end
end
