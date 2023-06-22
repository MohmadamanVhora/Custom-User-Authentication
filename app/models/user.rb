class User < ApplicationRecord
  has_secure_password
  has_secure_token :remember_token

  validates :username, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :password, length: { minimum: 8, maximum: 14 }
  validate :password_requirements
  validates :credit_card, presence: true, numericality: true, length: { is: 16 }
  validates :cvv, presence: true, length: { is: 3 }

  private

  def password_requirements
    rules = {
      'must contain at least one lowercase letter' => /[a-z]+/,
      'must contain at least one uppercase letter' => /[A-Z]+/,
      'must contain at least one digit' => /\d+/,
      'must contain at least one special character' => /[^A-Za-z0-9]+/
    }

    rules.each do |message, regex|
      errors.add(:password, message) unless password&.match(regex)
    end
  end 
end
