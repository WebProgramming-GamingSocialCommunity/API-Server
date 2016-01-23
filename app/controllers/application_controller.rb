class ApplicationController < ActionController::API
  include AbstractController::Translation

  before_action :authenticate_user!

  respond_to :json

end
