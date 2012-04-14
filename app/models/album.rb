class Album < ActiveRecord::Base
  attr_accessible :description, :photo_id, :name
  belongs_to :photo
  has_many :photos
end
