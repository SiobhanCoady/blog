class UsersMailer < ApplicationMailer
  def send_reset_password_link(user, token)
    @user = user
    @token = token
    mail(to: @user.email, subject: "Password reset link inside")
  end
end
