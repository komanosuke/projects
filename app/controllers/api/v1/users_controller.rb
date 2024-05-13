class Api::V1::UsersController < ApplicationController
    skip_before_action :authenticate_request, only: [:create]
    before_action :set_user, only: [:show, :follows, :followers, :update, :destroy]
    # before_action :logged_in_user, except: [:new, :create, :confirm, :back, :success]

    # GET /users or /users.json
    def index
        @users = User.all
        render json: @users
    end

    # GET /users/current
    def current
        render json: @current_user
    end

    # GET /users/new
    def new
        @user = User.new
    end

    # GET /users/1
    def show
        render json: UserPresenter.new(@user, @current_user).as_json
    end

    # GET /users/1/edit
    def edit
        
    end

    # # PATCH/PUT /users/me
    # def update
    #     if @current_user.update(user_params)
    #         render json: @current_user
    #     else
    #         render json: @current_user.errors, status: :unprocessable_entity
    #     end
    # end

    # # DELETE /users/me
    # def destroy
    #     @current_user.destroy
    #     head :no_content
    # end

    # POST /users or /users.json
    def create
        ActiveRecord::Base.transaction do
            @user = User.new(user_params)
        
            if @user.save
                Cart.create!(user_id: @user.id)
                StudyRecord.create!(user_id: @user.id)
                Lifecost.create!(user_id: @user.id)
                UserMailer.account_activation(@user).deliver_now
                p 'USER CREATED'
                # flash[:notice] = "アカウント仮登録が完了しました！以下の手続きに従って下さい。"
                @user.update!(address: @user.prefecture + @user.city + @user.street, username: '@' + @user.username)
        
                render json: { message: "アカウントが作成されました！" }, status: :created
            else
                render json: { message: "アカウント作成に失敗しました", errors: @user.errors.full_messages }, status: :unprocessable_entity
            end
        end
    rescue ActiveRecord::RecordInvalid => e
    # 例外が発生した場合はここでキャッチ
        render json: { message: "アカウント作成に失敗しました。エラー: #{e.message}", errors: e.record.errors.full_messages }, status: :unprocessable_entity
    end

    # PATCH/PUT /users/1 or /users/1.json
    def update
        if @user.update(user_params)
            @user.update(address: @user.prefecture + @user.city + @user.street)
            flash[:notice] = "アカウントが更新されました！"
            if user_params[:photo] or user_params[:audio] or user_params[:video]
                redirect_to "/socket"
            else
                redirect_to "/users/" + params[:id] + "/edit"
            end
        else
            flash.now[:alert] = "作成に失敗しました"
        end
    end

    # DELETE /users/1 or /users/1.json
    def destroy
        @user.destroy

        # respond_to do |format|
        #     format.html { redirect_to users_url, notice: "User was successfully destroyed." }
        #     format.json { head :no_content }
        # end
    end

    def confirm
        if logged_in?
            render :login
        else
            @user = User.new(user_params)
            if @user.invalid?
                render :new
            end
        end
    end

    def back
        if logged_in?
            render :login
        else
            @user = User.new(user_params)
            render :new
        end
    end

    def success
        if logged_in?
            render :login
        end
    end

    # GET /users/:id/follows
    def follows
        @followed_users = @user.followeds
        render json: @followed_users.map { |user| UserPresenter.new(user, @current_user).as_json }
    end

    # GET /users/:id/followers
    def followers
        @follower_users = @user.followers
        render json: @follower_users.map { |user| UserPresenter.new(user, @current_user).as_json }
    end

    private

    def set_user
        @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
        params.require(:user).permit(:name, :username, :email, :password, :zip, :prefecture, :city, :street, :address, :tel, :image, :photo, :audio, :video, :profile, :introduction)
    end
end
