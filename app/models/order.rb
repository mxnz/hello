class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :product

  validates :user, :product, :url, :thumbnail_url, presence: true
end
