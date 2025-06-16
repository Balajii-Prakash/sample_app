class User < ApplicationRecord
  # Virtual attributes for tokens
  attr_accessor :session_token
  attr_accessor :remember_token

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
  validates :password, presence: true, length: { minimum: 6 }, allow_blank: true

  # Class method to generate digest for tokens
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Class method to generate a new random token
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # Remember user by storing token digest in DB
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Forget user (clear remember_digest)
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Verify if token matches digest
  def authenticated?(token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(token)
  end
end
