class Api::V1::LikesController < ApplicationController
    before_action :set_post

    def create
        like = @current_user.likes.build(post: @post)
        if like.save
            render json: { liked: true, likesCount: @post.likes.count }, status: :created
        else
            render json: { errors: like.errors.full_messages }, status: :unprocessable_entity
        end
    end
    
    def destroy
        like = @current_user.likes.find_by(post: @post)
        if like&.destroy
            render json: { liked: false, likesCount: @post.likes.count }, status: :ok
        else
            render json: { errors: ["Like not found or could not be deleted"] }, status: :unprocessable_entity
        end
    end
    
    private
    
    def set_post
        @post = Post.find(params[:post_id])
    rescue ActiveRecord::RecordNotFound
        render json: { errors: ["Post not found"] }, status: :not_found
    end
end


