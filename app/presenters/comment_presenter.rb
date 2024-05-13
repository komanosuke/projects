class CommentPresenter
    def initialize(comment)
        @comment = comment
    end

    def as_json(*)
        {
            id: @comment.id,
            content: @comment.content,
            user_id: @comment.user.id,
            user_name: @comment.user.name,
            user_username: @comment.user.username,
            user_image_url: @comment.user.image.url,
            created_at: @comment.created_at,
        }
    end
end
  