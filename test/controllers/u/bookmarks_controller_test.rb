# frozen_string_literal: true

require 'test_helper'

class U::BookmarksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user)
    @u_post = create(:user_content_post)
  end

  teardown do
    logout_user
  end

  test 'should create bookmark' do
    login_user @user

    assert_difference('UserContent::Bookmark.count') do
      patch u_bookmark_url(@u_post)
    end

    assert_redirected_to u_bookmark_url(@u_post)
  end

  test 'should remove bookmark' do
    login_user @user

    bm = UserContent::Bookmark.create(user_content: @u_post, user: @user)

    assert_difference('UserContent::Bookmark.count', -1) do
      delete u_bookmark_url(@u_post)
    end

    assert_redirected_to u_bookmark_url(@u_post)
  end
end
