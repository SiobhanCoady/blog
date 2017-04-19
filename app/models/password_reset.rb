class PasswordReset < ApplicationRecord
  belongs_to :user

  validates :token, presence: true,
                    uniqueness: { case_sensitive: false }
end
