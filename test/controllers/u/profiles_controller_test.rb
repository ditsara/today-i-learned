# frozen_string_literal: true

require 'test_helper'

class U::ProfilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user)
  end

  teardown do
    logout_user
  end

  test 'should show user' do
    login_user @user
    get u_profiles_url
    assert_response :success
  end

  test 'should get edit' do
    login_user @user
    get edit_u_profiles_url
    assert_response :success
  end

  test 'should update user (redirect to #show)' do
    login_user @user
    patch u_profiles_url,
      params: { user: { name: 'NewName' } }
    assert_redirected_to edit_u_profiles_url
  end
end
