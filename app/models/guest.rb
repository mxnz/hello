class Guest < User
  validates :password, length: { minimum: 6 }
end
