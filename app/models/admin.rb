class Admin < User
  validates :name, :last_name, :avatar, :passport_photo, :birthdate, presence: true
  validates :password, length: { minimum: 10 }
end
