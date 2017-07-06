class User < ApplicationRecord
  before_save { email.downcase! }
  VALID_USER_NAME_REGEX = /\A(\w+)\z/i
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :user_name, presence: true,
                        length: { maximum: 30 },
                        uniqueness: { case_sensitive: false},
                        format: { with: VALID_USER_NAME_REGEX }
  validates :email, presence: true,
                    length: { maximum: 255 },
                    uniqueness: { case_sensitive: false},
                    format: { with: VALID_EMAIL_REGEX }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
end
