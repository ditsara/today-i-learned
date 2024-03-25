# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'creates a user' do
    assert_difference 'User.count', 1 do
      create :user
    end
  end

  test 'removes a user' do
    create :user
    assert_difference 'User.count', -1 do
      User.first.destroy
    end
  end

  test 'validates email presence' do
    u = build :user

    u.email = nil
    assert_equal u.valid?, false

    u.email = 'is-an-email@mailinator.com'
    assert_equal u.valid?, true
  end

  test 'validates email format' do
    u = build :user

    u.email = 'not-an-email'
    assert_equal u.valid?, false

    u.email = 'is-an-email@mailinator.com'
    assert_equal u.valid?, true
  end
end
