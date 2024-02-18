require 'test_helper'

class U::PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user)
    @u_post = create(:user_content_post, owner: @user)
  end

  teardown do
    logout_user
  end

  test 'should get index' do
    login_user @user
    get u_posts_url
    assert_response :success
  end

  # test "should get new" do
  #   get new_u_post_url
  #   assert_response :success
  # end

  # test "should create u_post" do
  #   assert_difference("U::Post.count") do
  #     post u_posts_url, params: { u_post: {  } }
  #   end

  #   assert_redirected_to u_post_url(U::Post.last)
  # end

  test 'should show post' do
    login_user @user
    get u_post_url(@u_post)
    assert_response :success
  end

  test 'should get edit' do
    login_user @user
    get edit_u_post_url(@u_post)
    assert_response :success
  end

  test 'should update u_post (redirect to #show)' do
    login_user @user
    new_title = "New Title #{SecureRandom.uuid}"
    patch u_post_url(@u_post),
          params: { user_content_post: { title: new_title } }
    assert_redirected_to u_post_url(@u_post)
  end

  test '(not owner) should not update u_post' do
    @other_user = create :user
    login_user @other_user
    new_title = "New Title #{SecureRandom.uuid}"
    patch u_post_url(@u_post),
          params: { user_content_post: { title: new_title } }
    assert_response :forbidden
  end

  # test "should destroy u_post" do
  #   assert_difference("U::Post.count", -1) do
  #     delete u_post_url(@u_post)
  #   end

  #   assert_redirected_to u_posts_url
  # end
end
