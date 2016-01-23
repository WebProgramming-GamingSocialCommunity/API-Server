require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end
  test "login with valid information" do
    post v1_login_url, { email: @user.email, password: 'password' }
    json = JSON.parse(@response.body)
    assert_response 200
    assert_equal "Michael Example", json['username']
  end

end
