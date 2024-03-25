# frozen_string_literal: true

require 'test_helper'

class User::RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get new_user_registrations_url
    assert_response :success
  end

  test 'create new user' do
    user = build :user
    assert_difference 'User.count', 1 do
      post user_registrations_url, params: {
        user: {
          email: user.email,
          password: user.password,
          password_confirmation: user.password
        }
      }
    end
    assert_redirected_to root_path
    assert_not_nil flash[:notice]
  end

  test 'does not create new user' do
    user = build :user
    assert_difference 'User.count', 0 do
      post user_registrations_url, params: {
        user: {
          email: 'bad email',
          password: user.password,
          password_confirmation: user.password
        }
      }
    end
    assert_template 'user/registrations/new'
    assert_response :unprocessable_entity

    assert_difference 'User.count', 0 do
      post user_registrations_url, params: {
        user: {
          email: user.email,
          password: 'short!!',
          password_confirmation: 'short!!'
        }
      }
    end
    assert_template 'user/registrations/new'
    assert_response :unprocessable_entity

    assert_difference 'User.count', 0 do
      post user_registrations_url, params: {
        user: {
          email: user.email,
          password: 'notmatching1111',
          password_confirmation: 'notmatching2222'
        }
      }
    end
    assert_template 'user/registrations/new'
    assert_response :unprocessable_entity
  end
end
