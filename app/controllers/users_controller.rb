class UsersController < ApplicationController
  skip_before_action :authorize_request, only: [:create, :reset_password, :update_password]
  
  def create
    user = User.new(user_params)
    if user.save
      token = JWT.encode({ user_id: user.id }, Rails.application.secrets.secret_key_base)
      render json: { user: user, token: token }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def reset_password
    user = User.find_by(email: params[:email])
    if user
      user.generate_reset_password_token
      user.save
      render json: { message: 'Reset password token generated', reset_password_token: user.reset_password_token }
    else
      render json: { error: 'User not found' }, status: :not_found
    end
  end

  def update_password
    user = User.find_by(reset_password_token: params[:reset_password_token])
    if user && user.reset_password_token_valid?
      user.update(password: params[:password], reset_password_token: nil, reset_password_token_expires_at: nil)
      render json: { message: 'Password updated successfully' }
    else
      render json: { error: 'Invalid or expired reset password token' }, status: :unprocessable_entity
    end
  end

  private
    
  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end

