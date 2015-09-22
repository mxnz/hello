class Admin < User
  def self.minimum_password_length() 10; end

  validates :name, :last_name, :avatar, :passport_photo, :birthdate, presence: true
  validates :password, length: { minimum: minimum_password_length }
end
