require 'test_helper'
include Warden::Test::Helpers

class UsersLogoutTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end
  test "logout" do
    post v1_login_url, { email: @user.email, password: 'password' }
    json = JSON.parse(@response.body)
    assert_response 200
    assert_equal "Michael Example", json['username']
    delete v1_logout_url
    assert_response 200
    Warden.test_reset!
  end
end
