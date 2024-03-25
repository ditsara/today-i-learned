# frozen_string_literal: true

require 'test_helper'

class User::PasswordResetsControllerTest < ActionDispatch::IntegrationTest
  test 'show new page' do
    get new_user_password_reset_url
    assert_response :success
  end

  test 'changes password reset token' do
    user = create :user
    assert_changes -> { user.reload.reset_password_token } do
      post user_password_resets_url, params: { email: user.email }
    end
    assert_redirected_to root_path
  end

  test 'show edit page' do
    user = create :user
    user.deliver_reset_password_instructions!
    get edit_user_password_reset_url(id: user.reset_password_token)
    assert_response :success
  end

  test 'changes password' do
    user = create :user
    user.deliver_reset_password_instructions!
    assert_changes -> { user.reload.crypted_password } do
      put user_password_reset_path(id: user.reset_password_token),
        params: { password_confirmation: 'Abcd1234$', password: 'Abcd1234$' }
    end
  end
end
