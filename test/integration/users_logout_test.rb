require 'test_helper'
include Warden::Test::Helpers

class UsersLogoutTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end
  test "logout" do
    post user_session_url, { email: @user.email, password: 'password' }
    json = JSON.parse(@response.body)
    assert_response 200
    assert_equal "Michael Example", json['username']
    delete destroy_user_session_url
    assert_response 204
    Warden.test_reset!
  end
end
