class Api::V1::CommentsController < ApplicationController

    def index
        @post = Post.find(params[:post_id])
        @comments = @post.comments.includes(:user).order(created_at: :desc).page(params[:page]).per(3)
        render json: @comments.map { |comment| CommentPresenter.new(comment).as_json }
    end

    def create
        comment = @current_user.comments.build(post_id: params[:post_id], content: params[:content])
        if comment.save
            render json: CommentPresenter.new(comment).as_json
        else
            render json: { message: "コメント作成に失敗しました", errors: comment.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def destroy
        comment = Comment.find_by(post_id: params[:post_id], user_id: @current_user.id)
        if comment
            comment.destroy
            render json: { message: "コメントが削除されました" }, status: :ok
        else
            render json: { message: "削除するコメントが見つかりません" }, status: :not_found
        end
    end
end