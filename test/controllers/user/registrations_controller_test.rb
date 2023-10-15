require "test_helper"

class User::RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_user_registrations_url
    assert_response :success
  end

  test "create new user" do
    user = build :user
    post user_registrations_url, params: {
      user: {
        email: user.email,
        password: user.password,
        password_confirmation: user.password
      }
    }

    assert_redirected_to root_path
  end

  test "does not create new user" do
    user = build :user
    post user_registrations_url, params: {
      user: {
        email: "bad email",
        password: user.password,
        password_confirmation: user.password
      }
    }
    assert_response :success # renders "new" template

    post user_registrations_url, params: {
      user: {
        email: user.email,
        password: "short!!",
        password_confirmation: "short!!"
      }
    }
    assert_response :success # renders "new" template

    post user_registrations_url, params: {
      user: {
        email: user.email,
        password: "notmatching1111",
        password_confirmation: "notmatching2222"
      }
    }
    assert_response :success # renders "new" template
  end
end
