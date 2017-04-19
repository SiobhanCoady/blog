class User < ApplicationRecord
  has_secure_password

  attr_accessor :old_password
  attr_accessor :new_password
  # attr_accessor :remember_token, :activation_token, :reset_token

  validates :first_name, presence: true
  validates :last_name, presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    format: VALID_EMAIL_REGEX

  before_validation :downcase_email
  # before_create { generate_token(:auth_token) }

  has_many :posts, dependent: :nullify
  has_many :comments, dependent: :nullify
  has_many :password_resets, dependent: :destroy

  def new_password_same_as_old?
    puts "Old password: #{old_password}"
    puts "New password: #{new_password}"
    old_password == new_password
  end

  # def generate_token(column)
  #   begin
  #     self[column] = SecureRandom.urlsafe_base64
  #   end while User.exists?(column => self[column])
  # end
  #
  # def create_reset_digest
  #   # self.reset_token = User.new_token
  #   generate_token(:reset_token)
  #   update_attribute(:reset_digest,  User.digest(reset_token))
  #   update_attribute(:reset_sent_at, Time.zone.now)
  #   byebug
  # end
  #
  # def send_password_reset_email
  #   # UserMailer.password_reset(self).deliver_now
  # end
  #
  private

    def downcase_email
      self.email.downcase! if email.present?
    end

end
