# frozen_string_literal: true
class UserMailer < ApplicationMailer
  def reset_password_email(user)
    @user = User.find user.id
    @url = edit_user_password_reset_url(id: @user.reset_password_token)
    mail to: @user.email, subject: 'Reset password request'
  end
end
