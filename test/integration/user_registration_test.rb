require 'test_helper'

class UserRegistrationTest < ActionDispatch::IntegrationTest

  def setup
    # https://bitbucket.org/mailchimp/mandrill-api-ruby/wiki/Home
    # stubs any request to return an empty JSON string
    Excon.defaults[:mock] = true
    Excon.stub({}, {body: '{}', status: 200})
  end

 test "valid signup information" do
    get new_user_registration_path
    assert_difference 'User.count', 1 do
      post_via_redirect user_registration_path, user: { name:  "Example User",
                                                email: "tim@email.com",
                                                password: "password",
                                                password_confirmation: "password" }
    end
    assert_template 'static_pages/home'
  end
end
