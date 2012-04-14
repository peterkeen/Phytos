class Photo < ActiveRecord::Base
  attr_accessible :description, :name, :photo, :photo_cache
  mount_uploader :photo, PhotoUploader
  process_in_background :photo
end
