class Api::V1::PasswordResetsController < ApplicationController
  skip_before_action :authenticate_request, only: [:create, :update]

  def new
  end

  def create
    @user = User.find_by(email: params[:email].downcase)
    if @user
      begin
        ActiveRecord::Base.transaction do
          @user.create_reset_digest
          @user.send_password_reset_email
        end
        render json: { message: "Password reset email sent successfully." }, status: :ok
      rescue ActiveRecord::RecordInvalid => e
        render json: { message: "Failed to send password reset email.", errors: e.record.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { message: "Email address not found." }, status: :not_found
    end
  end

  def update
    p user_params
    token = params[:id]  # Assuming the token is sent as a URL parameter
    @user = User.find_by(email: params[:email].downcase)

    # First, check if the user exists and the token matches and is not expired.
    if @user && @user.authenticated?(:reset, token) && !@user.password_reset_expired?
      if params[:user][:password].blank?
        @user.errors.add(:password, :blank)
        render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
      else
        if @user.update(user_params)
          render json: { message: "Password has been reset successfully." }, status: :ok
        else
          render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
      end
    else
      render json: { message: "Invalid or expired password reset token." }, status: :unprocessable_entity
    end
  end


  private
    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end
end
