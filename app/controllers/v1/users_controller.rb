module V1
  class UsersController < ApplicationController
    skip_before_action :authenticate_user!, only: [:index, :show, :create]
    before_action :logged_in_user, only: [:edit, :update, :destroy]
    before_action :correct_user, only: [:edit, :update, :destroy]

    def index
      render json: User.all
    end


    def show
      @user = User.find(params[:id])
      @posts = @user.posts
      render json: { :user => @user,
                     :posts => @posts }
    end

    # POST /users
    # POST /users.json
    def create
      @user = User.new(user_params)

      if @user.save
        render :show, status: :created, location: :v1_user_url
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /users/1
    # PATCH/PUT /users/1.json
    def update
      @user = set_user
      if @user.update(user_params)
        #format.html { redirect_to @user, notice: 'User was successfully updated.' }
        render :show, status: :ok, location: :v1_user_url
      else
        #format.html { render :edit }
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    # DELETE /users/1
    # DELETE /users/1.json
    def destroy
      @user.destroy
      respond_to do |format|
        #format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
        format.json { head :no_content }
      end
    end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :username, :password, :password_confirmation)
    end

    def logged_in_user
      unless user_signed_in?
        render status: :unauthorized
      end
    end

    def correct_user
      @user = User.find(params[:id])
      unless @user === current_user
          render status: :unauthorized
      end
    end
  end
end
