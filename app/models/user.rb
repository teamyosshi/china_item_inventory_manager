class User < ApplicationRecord
  has_many :researches, dependent: :destroy
  attr_accessor :remember_token
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 60},
              format: { with: VALID_EMAIL_REGEX },
              uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, presence: true, length: { in: 6..30 }, allow_nil: true
  validates :line_id, length: {maximum: 255}
  validates :address, presence: true, length: { maximum: 255}
  validates :phone_number, presence: true, length: {maximum: 255}
  validates :employee_number, length: {maximum: 255}
  validates :fired_flg, length: {maximum: 50}
  validates :inventory_manager_flg ,acceptance: true, if: :reserch_user_flg_validation?
  validates :reserch_user_flg, acceptance: true, if: :inventory_manager_flg_validation?
  def reserch_user_flg_validation?
    reserch_user_flg == false
  end

  def inventory_manager_flg_validation?
    inventory_manager_flg == false
  end

  def User.digest(string)
    cost =
      if ActiveModel::SecurePassword.min_cost
        BCrypt::Engine::MIN_COST
      else
        BCrypt::Engine.cost
      end
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, :nil)
  end
end
