require "test_helper"

class U::FeedsControllerTest < ActionDispatch::IntegrationTest
  test "should get recent" do
    get u_feeds_recent_url
    assert_response :success
  end
end
