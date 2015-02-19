require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
  end

  test "home page when user not signed in" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", new_user_session_path
    assert_select "a[href=?]", new_user_registration_path
  end


 test "home page when user signed in" do
    get new_user_session_path
    post_via_redirect new_user_session_path, user: { email: @user.email, password: 'watermellon' }
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 3
    assert_select "a[href=?]", new_vote_path
    assert_select "a[href=?]", votes_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", destroy_user_session_path
 end
end
