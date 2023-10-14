require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "creates a user" do
    assert_difference 'User.count', 1 do
      create :user
    end
  end

  test "removes a user" do
    create :user
    assert_difference 'User.count', -1 do
      User.first.destroy
    end
  end
end
