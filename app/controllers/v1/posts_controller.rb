module V1
  class PostsController < ApplicationController
    skip_before_action :authenticate_user!
    before_action :set_post, only: [:show, :edit, :update, :destroy]
    before_action :user_signed_in, except: [:index, :show]

    # GET /posts
    # GET /posts.json
    def index
      render json: Post.all
    end

    # GET /posts/1
    # GET /posts/1.json
    def show
      @post = Post.find(params[:id])
      render json: { :post => @post }
    end

    # POST /posts
    # POST /posts.json
    def create
      @post = Post.new(post_params)

      if @post.save
        render :show, status: :created, location: :v1_post_url
      else
        render json: @post.errors, status: :unprocessable_entity
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_post
        @post = Post.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def post_params
        params.require(:post).permit(:title, :content, :user_id)
      end

  end
end
