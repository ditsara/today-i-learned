require "test_helper"

class User::SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_user_sessions_url
    assert_response :success
  end

  test "logs in user" do
    user = build :user
    pw = user.password # this is erased after we save the user
    user.save

    post user_sessions_url,
      params: { email: user.email, password: pw }
    assert_redirected_to root_path
  end

  test "does not log in user" do
    user = create :user
    post user_sessions_url, params: {
      email: user.email,
      password: "definitely-wrong-#{SecureRandom.uuid}"
    }
    assert_response :success
  end
end
