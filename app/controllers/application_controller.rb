class ApplicationController < ActionController::API
  include AbstractController::Translation
  include ActionController::MimeResponds

  def self.respond_to(*mimes)
    include ActionController::RespondWith::ClassMethods
  end
  before_action :allow_cross_origin_requests, if: proc { Rails.env.development? }
  before_action :authenticate_user!

  respond_to :json
  def preflight
    render nothing: true
  end

private
  def allow_cross_origin_requests
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
    headers['Access-Control-Max-Age'] = '1728000'
  end  

end
