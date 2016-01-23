require 'test_helper'
module V1
  class UsersControllerTest < ActionController::TestCase
    include Devise::TestHelpers
    def setup
      @controller = UsersController.new
      @user = users(:michael)
      @other_user = users(:archer)
    end
    test "should create user" do
      assert_difference('User.count') do
        post :create, user: { username:'beddasd', email:'fffd@msn.com', password:'12345678', password_confirmation:'12345678' }, format: :json
      end

      assert_response :success
    end

    test "should get index" do
      get :index
      json = JSON.parse(@response.body)
      assert_response :success
      users_names = json.map { |m| m['username'] }
      assert_equal users_names, ["Michael Example", "Sterling Archer", "Alice"]
    end

    test "should show user" do
      get :show, id: @user, format: :json
      json = JSON.parse(@response.body)
      assert_response :success
      assert_equal @user.email, json['user']['email']
    end

    test "should return 401 when not logged in" do
      patch :update, id: @user, user: { username: @user.username, email: @user.email }, format: :json
      assert_response 401
    end

    test "should update user" do
      sign_in @user
      patch :update, id: @user, user: { username:'bek', email:'1e43@fjl.com', password:'12345678', password_confirmation:'12345678' }, format: :json
      assert_response 200
    end

    test "should not update user" do
      sign_in @user
      patch :update, id: @user, user: { username:'bek', email:'1e43@fjl.com', password:'12345678', password_confirmation:'12678' }, format: :json
      json = JSON.parse(@response.body)
      assert_response 422
      assert_equal ["doesn't match Password"], json['password_confirmation']
    end

    test "should return 401 when logged in as wrong user" do
      sign_in @other_user
      patch :update, id: @user, user: { username: @user.username, email: @user.email }, format: :json
      assert_response 401
    end


    test "should not destroy user" do
      assert_no_difference('User.count') do
        delete :destroy, id: @user, format: :json
      end
      assert_response 401
    end

    test "should show user's post" do
      get :show, id: @user, format: :json
      json = JSON.parse(@response.body)
      assert_response :success
      assert_equal @user.posts, json['posts']
    end

  end
end
