require 'test_helper'

class UserLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:one)
  end

  test 'invalid login' do
    get new_user_session_path
    assert_template 'devise/sessions/new'
    post new_user_session_path, user: { email: 'jeb@email.com', password: '' }
    assert_template 'devise/sessions/new'
    assert_not flash.empty?
  end

  test 'valid login and logout' do
    get new_user_session_path
    post_via_redirect new_user_session_path, user: { email: @user.email, password: 'watermellon' }
    assert_template 'static_pages/home'
    assert assigns(:invites_presenter)
    assert assigns(:votes_presenter)
    delete destroy_user_session_path
    assert_redirected_to root_path
  end
end
