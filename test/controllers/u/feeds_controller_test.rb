require "test_helper"

class U::FeedsControllerTest < ActionDispatch::IntegrationTest
  setup do
    u = create :user
    login_user(u)
  end

  teardown do
    logout_user
  end

  test "should get recent" do
    get u_feeds_recent_url
    assert_response :success
  end
end
