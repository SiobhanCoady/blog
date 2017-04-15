class User < ApplicationRecord
  has_secure_password

  attr_accessor :old_password
  attr_accessor :new_password

  validates :first_name, presence: true
  validates :last_name, presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    format: VALID_EMAIL_REGEX

  before_validation :downcase_email

  has_many :posts, dependent: :nullify
  has_many :comments, dependent: :nullify

  def new_password_same_as_old?
    puts "Old password: #{old_password}"
    puts "New password: #{new_password}"
    old_password == new_password
  end

  private

    def downcase_email
      self.email.downcase! if email.present?
    end

end
