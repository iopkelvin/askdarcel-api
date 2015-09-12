class AddAttachmentPhotoToResourceImages < ActiveRecord::Migration
  def self.up
    change_table :resource_images do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :resource_images, :photo
  end
end
