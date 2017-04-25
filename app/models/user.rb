class User < ApplicationRecord
  has_secure_password

  attr_accessor :old_password

  validates :first_name, presence: true
  validates :last_name, presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    format: VALID_EMAIL_REGEX

  before_validation :downcase_email

  validate :old_password_differs_from_new

  has_many :posts, dependent: :nullify
  has_many :comments, dependent: :nullify
  has_many :password_resets, dependent: :destroy

  private

    def downcase_email
      self.email.downcase! if email.present?
    end

    def old_password_differs_from_new
      if old_password == password
        errors.add(:password, "New password must be different from old password")
      end
    end

end
