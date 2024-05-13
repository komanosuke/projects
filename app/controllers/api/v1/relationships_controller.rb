class Api::V1::RelationshipsController < ApplicationController
    
    def create
      user = User.find(params[:user_id])
      @current_user.follow(user)
      if @current_user.save
        render json: { is_following: true }, status: :created
      else
        render json: { errors: @current_user.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def destroy
      user = User.find(params[:user_id])
      @current_user.unfollow(user)
      if @current_user.save
        render json: { is_following: false }, status: :ok
      else
        render json: { errors: @current_user.errors.full_messages }, status: :unprocessable_entity
      end
    end
end
