class Guest < User
  def self.minimum_password_length() 6; end

  validates :password, length: { minimum: minimum_password_length }
end
