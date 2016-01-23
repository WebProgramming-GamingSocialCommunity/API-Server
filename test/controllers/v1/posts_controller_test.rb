require 'test_helper'
module V1
  class PostsControllerTest < ActionController::TestCase
    include Devise::TestHelpers
    test "should return all posts" do
      get :index
      json = JSON.parse(response.body)
      assert_response :success
      post_titles = json.map { |m| m["title"] }
      assert_equal post_titles, ["kek", "orange", "kitty", "tau"]
    end

    test "should return single post" do
      @post = posts(:orange)
      get :show, id:@post, format: :json
      json = JSON.parse(response.body)
      assert_response :success
      assert_equal @post.title, json['post']['title']
    end

    test "should create post" do
      @user = users(:michael)
      sign_in @user
      assert_difference('Post.count') do
        post :create, post: {title: "Lorem ipsum", content: "Lorem ipsum", user_id: @user.id}, format: :json
      end
      assert_response :success
    end

  #  tests "should redirect create when not logged in" do
  #    assert_no_difference 'Post.count' do
  #      post :create, post: {content: "Lorem ipsum"}
  #    end
  #    assert_redirected_to login
  #  end
  #
  #  tests "should redirect destroy when not logged in" do
  #    @post = posts(:orange)
  #    assert_no_difference 'Post.count' do
  #      delete :destroy, id: @post
  #    end
  #    assert_redirected_to login
  #  end

  end
end
