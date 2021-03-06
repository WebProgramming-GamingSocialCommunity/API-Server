module V1
  class SessionsController < Devise::SessionsController
    skip_before_action :authenticate_user
    respond_to :json
    # POST /v1/login
    def create
      @user = User.find_for_database_authentication(email: params[:email])
      return invalid_login_attempt unless @user

      if @user.valid_password?(params[:password])
        sign_in :user, @user
        render json: @user, serializer: SessionSerializer, root: nil
      else
        invalid_login_attempt
      end
    end

    def destroy
      sign_out
      render :nothing => true, :status => 204
     end

    private

    def invalid_login_attempt
      warden.custom_failure!
      render json: {error: t('sessions_controller.invalid_login_attempt')}, status: :unprocessable_entity
    end

  end
end
