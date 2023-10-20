require "test_helper"

class UserContent::PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "is valid" do
    p = build :user_content_post
    assert_instance_of User, p.owner
    assert_nil p.parent
    assert p.valid?
  end

  test "no owner (invalid)" do
    p = build :user_content_post, owner: nil
    assert_not p.valid?
  end
end
