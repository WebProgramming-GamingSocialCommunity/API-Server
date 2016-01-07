module V1
  class PostsController < ApplicationController
    before_action :set_post, only: [:show, :edit, :update, :destroy]

    # GET /posts
    # GET /posts.json
    def index
      render json: Post.all
    end

    # GET /posts/1
    # GET /posts/1.json
    def show
      render json: Post.find(params[:id])
    end

    # POST /posts
    # POST /posts.json
    def create
      @post = Post.new(post_params)

      respond_to do |format|
        if @post.save
          format.json { render :show, status: :created, location: @post }
        else
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
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
