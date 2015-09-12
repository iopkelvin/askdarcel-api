class ResourceImage < ActiveRecord::Base
  belongs_to :resource

  has_attached_file :photo, :styles => { :thumbnail => "50x50#", :medium => "200x200>", :large => "400x400>" }
  validates_attachment_presence :photo
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/
  validates_attachment_size :photo, :less_than => 5.megabytes
end
