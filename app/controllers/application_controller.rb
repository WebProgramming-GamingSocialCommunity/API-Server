class ApplicationController < ActionController::API
  include AbstractController::Translation
  include ActionController::MimeResponds

  def self.respond_to(*mimes)
    include ActionController::RespondWith::ClassMethods
  end
  before_action :authenticate_user!

  respond_to :json

end
