class Product < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :store, presence: true

  attr_readonly :store

  mount_uploader :photo, PhotoUploader
end
