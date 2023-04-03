class ApplicationController < ActionController::API
    before_action :authorize_request


    private
  
    def authorize_request
      header = request.headers['Authorization']
      header = header.split(' ').last if header
  
      begin
        decoded = JWT.decode(header, Rails.application.secrets.secret_key_base, true, algorithm: 'HS256')
        @current_user_id = decoded[0]['user_id']
        @current_user = User.find(@current_user_id)
      rescue JWT::DecodeError
        render json: { error: 'Invalid token' }, status: :unauthorized
      end
    end
end
