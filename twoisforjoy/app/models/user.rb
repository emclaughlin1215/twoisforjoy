class User < ApplicationRecord
  before_create do |user|
    user.api_key = user.generate_api_key
  end
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 255 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  has_secure_token

  def generate_api_key
    loop do
      token = SecureRandom.base64.tr('+/=', 'Qrt')
      break token unless User.exists?(api_key: token)
    end
  end

  def self.valid_login?(email, password)
    user = User.find_by(email: email)
    if user && user.authenticate(password)
      user
    end
  end

  def allow_token_to_be_used_only_once
    regenerate_token
    touch(:token_created_at)
  end

  def logout
    invalidate_token
  end

  def with_unexpired_token(token, period)
    where(token: token).where('token_created_at >= ?', period).first
  end

  private

    def invalidate_token
      self.update_columns(token: nil)
      touch(:token_created_at)
    end
end
