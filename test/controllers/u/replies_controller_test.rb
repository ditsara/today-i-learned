# frozen_string_literal: true
require 'test_helper'

class U::RepliesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user)
    @u_post = create(:user_content_post, owner: @user)
    @u_reply = create(:user_content_reply, owner: @user, parent: @u_post)
  end

  teardown do
    logout_user
  end

  test 'should get new' do
    login_user @user
    get new_u_post_reply_url(post_id: @u_post.id)
    assert_response :success
  end

  test 'should create new reply' do
    login_user @user

    assert_difference('UserContent::Reply.count') do
      post u_post_replies_url(post_id: @u_post.id),
        params: { user_content_reply: { content: 'Hello' } }
    end

    assert_redirected_to u_post_url(id: @u_post.id)
  end

  test 'should get edit' do
    login_user @user
    get edit_u_post_reply_url(post_id: @u_post.id, id: @u_reply.id)
    assert_response :success
  end

  test 'should edit reply' do
    login_user @user
    patch u_post_reply_url(post_id: @u_post.id, id: @u_reply.id),
      params: { user_content_reply: { content: 'Modified' } }
    assert_redirected_to u_post_url(id: @u_post.id)
  end

  test '(not owner) should not edit reply' do
    login_user @user
    @other_user = create(:user)
    @u_reply.update owner: @other_user
    patch u_post_reply_url(post_id: @u_post.id, id: @u_reply.id),
      params: { user_content_reply: { content: 'Modified' } }
    assert_response :forbidden
  end
end
