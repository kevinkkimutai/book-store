class AuthenticationController < ApplicationController
    skip_before_action :authorize_request, only: :login
    def login
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
          token = JWT.encode({ user_id: user.id }, Rails.application.secrets.secret_key_base)
          render json: {message: "loggedin successfully",user: user, token: token }
        else
          render json: { error: 'Invalid email or password' }, status: :unauthorized
        end
      end
end
