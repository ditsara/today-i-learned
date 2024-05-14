require 'test_helper'

class UserContent::BookmarkTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test 'should not save bookmark without user_content' do
    bookmark = build :user_content_bookmark, user_content: nil
    assert_not bookmark.save, 'Saved the bookmark without a user_content'
  end

  test 'should not save bookmark without user' do
    bookmark = build :user_content_bookmark, user: nil
    assert_not bookmark.save, 'Saved the bookmark without a user'
  end

  test 'should save bookmark with user_content and user' do
    bookmark = build :user_content_bookmark
    assert bookmark.save, 'Not saved the bookmark with user_content and user'
  end

  test 'should not save bookmark with duplicate user_content and user' do
    bookmark = create :user_content_bookmark
    duplicate_bookmark = build :user_content_bookmark,
      user_content: bookmark.user_content, user: bookmark.user
    assert_not duplicate_bookmark.save,
      'Saved the bookmark with duplicate user_content and user'
  end

  test 'should save bookmarks on same content for different users' do
    bookmark = create :user_content_bookmark
    another_user = create :user
    another_bookmark = build :user_content_bookmark,
      user_content: bookmark.user_content, user: another_user
    assert another_bookmark.save,
      'Not saved the bookmark on same content for different users'
  end
end
