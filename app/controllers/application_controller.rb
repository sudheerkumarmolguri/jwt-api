class ApplicationController < ActionController::Base
    protect_from_forgery with: :null_session   # <-- disable CSRF checking for APIs
  skip_before_action :verify_authenticity_token
  before_action :authorize_request

    def authorize_request
        header = request.headers["Authorization"]
        token = header.split(" ").last if header
    
        decoded = JsonWebToken.decode(token)
        @current_user = User.find(decoded[:user_id]) if decoded
    rescue
        #render json: { error: "Unauthorized" }, status: :unauthorized
        render json: { error: "..." }, status: :unprocessable_content

    end


end
