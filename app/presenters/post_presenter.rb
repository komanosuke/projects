class PostPresenter
    def initialize(post, user)
        @post = post
        @user = user
    end

    def as_json(*)
        {
            id: @post.id,
            user_id: @post.user.id,
            content: @post.content,
            image_url: @post.image.url,
            created_at: @post.created_at,
            updated_at: @post.updated_at,
            user_name: @post.user.name,
            user_username: @post.user.username,
            user_image_url: @post.user.image.url,
            is_following: @user ? @post.user.followed_by?(@user) : false,
            initial_liked: @user ? @post.likes.exists?(user: @user) : false,
            initial_likes_count: @post.likes.count,
            initial_comments_count: @post.comments.count
        }
    end
end
  