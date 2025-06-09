class User < ApplicationRecord
  # Before saving, downcase the email
  before_save { self.email = email.downcase }

  # Name validations
  validates :name, presence: true, length: { maximum: 50 }

  # Email validations
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,
            presence: true,
            length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }

  # Secure password using bcrypt
  has_secure_password

  # Password validations
  validates :password, presence: true, length: { minimum: 6 }
end
