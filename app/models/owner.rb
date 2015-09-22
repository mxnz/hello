class Owner < User
  def self.minimum_password_length() 8; end

  validates :avatar, :store, presence: true
  validates :password, length: { minimum: minimum_password_length }
end
