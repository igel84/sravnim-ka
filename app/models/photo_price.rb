class PhotoPrice < ActiveRecord::Base
  belongs_to :user
  has_attached_file :photo, :styles => { :thumb=> ["770x770#", :png] }, :whiny => false
  validates_attachment_size :photo, :less_than => 1.megabyte
end
