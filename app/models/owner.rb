class Owner < User
  validates :avatar, :store, presence: true
  validates :password, length: { minimum: 8 }
end
