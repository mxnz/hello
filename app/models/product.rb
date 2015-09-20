class Product < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  mount_uploader :photo, PhotoUploader
end
