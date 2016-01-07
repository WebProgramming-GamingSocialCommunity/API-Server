require 'test_helper'
module V1
  class UsersControllerTest < ActionController::TestCase
    def setup
      @controller = UsersController.new
    end
    test "should create user" do
      assert_difference('User.count') do
        post :create, user: { username:'beddasd', email:'fffd@msn.com', password:'12345678', password_confirmation:'12345678' }, format: :json
      end

      assert_response :success
    end

  end
end
