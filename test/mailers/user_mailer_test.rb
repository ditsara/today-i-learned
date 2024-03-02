require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  # test "the truth" do
  #   assert true
  # end
  test 'reset password email' do
    user = create :user
    email = nil
    assert_emails 1 do
      email = user.deliver_reset_password_instructions!
    end

    assert_equal email.to, [user.email]
    assert_equal email.subject, 'Reset password request'
    assert_match user.reset_password_token, email.body.encoded
  end
end
