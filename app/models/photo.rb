class Photo < ActiveRecord::Base
  attr_accessible :description, :name, :photo, :photo_cache, :album_id
  mount_uploader :photo, PhotoUploader
  process_in_background :photo
  belongs_to :album
end
