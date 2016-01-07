module V1
  class UsersController < ApplicationController
    skip_before_action :authenticate_user_from_token!, only: [:create]

    def index
      render json: User.all
    end


    def show
      @user = User.find(params[:id])
      render json: { :user => @user }
    end

    # POST /users
    # POST /users.json
    def create
      @user = User.new(user_params)

      if @user.save
        render :show, status: :created, location: @user
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :name, :password, :password_confirmation)
    end
  end
end
