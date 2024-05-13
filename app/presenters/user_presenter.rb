class UserPresenter
    def initialize(user, current_user)
        @user = user
        @current_user = current_user
    end

    def as_json(*)
        {
            id: @user.id,
            name: @user.name,
            username: @user.username,
            profile: @user.profile,
            image_url: @user.image.url,
            is_following: @user.followed_by?(@current_user),
        }
    end
end
  