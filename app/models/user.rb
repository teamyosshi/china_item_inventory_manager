class User < ApplicationRecord
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 60},
              format: { with: VALID_EMAIL_REGEX },
              uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
  validates :line_id, length: {maximum: 255}
  validates :address, presence: true, length: { maximum: 255}
  validates :phone_number, presence: true, length: {maximum: 255}
  validates :employee_number, length: {maximum: 255}
  validates :fired_flg, length: {maximum: 50}
end
