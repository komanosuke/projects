class Api::V1::PostsController < ApplicationController
    skip_before_action :authenticate_request, only: [:index]
    before_action :optional_authenticate, only: [:index]
    before_action :set_user, only: [:posted, :liked, :commented]
    # GET /posts or /posts.json
    def index
        @posts = Post.includes(:user).page(params[:page]).per(3)
        render json: @posts.map { |post| PostPresenter.new(post, @current_user).as_json }
    end

    # GET /posts/1 or /posts/1.json
    def show
        @post = Post.find(params[:id])
        render json: PostPresenter.new(@post, @current_user).as_json
    end

    # GET /posts/new
    def new
        @post = Post.new
    end

    # GET /post/1/edit
    def edit
        
    end

    # POST /posts or /posts.json
    def create
        p @current_user
        @post = @current_user.posts.build(post_params)

        if @post.save
            render json: { message: "新しい投稿が作成されました！" }, status: :created
        else
            render json: { message: "作成に失敗しました", errors: @post.errors.full_messages }, status: :unprocessable_entity
        end
    end

    # PATCH/PUT /posts/1 or /posts/1.json
    def update
        if @post.update(post_params)
            redirect_to "/posts/" + params[:id] + "/edit"
            flash[:notice] = "投稿が更新されました！"
        else
            flash.now[:alert] = "作成に失敗しました"
        end
    end

    # DELETE /posts/1 or /posts/1.json
    def destroy
        @post.destroy

        respond_to do |format|
            format.html { redirect_to posts_url, notice: "投稿が削除されました！" }
            format.json { head :no_content }
        end
    end

    def posted
        @posts = @user.posts.page(params[:page]).per(3)
        render json: @posts.map { |post| PostPresenter.new(post, @user).as_json }
    end

    def liked
        @posts = @user.like_posts.page(params[:page]).per(3)
        p @posts
        render json: @posts.map { |post| PostPresenter.new(post, @user).as_json }
    end

    def commented
        @posts = @user.comment_posts.page(params[:page]).per(3)
        p @posts
        render json: @posts.map { |post| PostPresenter.new(post, @user).as_json }
    end

    private
        # Use callbacks to share common setup or constraints between actions.
        def set_user
            @user = User.find(params[:id])
        end

        def set_post
            @post = Post.find(params[:id])
        end

        # Only allow a list of trusted parameters through.
        def post_params
            params.require(:post).permit(:content, :image)
        end

        def optional_authenticate
            header = request.headers['Authorization']
            return unless header  # トークンがなければ何もせずリターン
        
            token = header.split(' ').last
            begin
                decoded = decode_token(token)
                @current_user = User.find_by(id: decoded[:user_id]) if decoded
            rescue JWT::DecodeError, JWT::ExpiredSignature
                # トークンが無効でもエラーを表示せず、@current_userはnilのままにする
                nil
            end
        end
end
