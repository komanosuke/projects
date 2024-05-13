class Api::V1::SessionsController < ApplicationController
    skip_before_action :authenticate_request, only: [:create]

    def create
        # ゲストログインの場合
        if params[:guest] == true
            user = create_guest_user
        else
            # 通常ログインの場合
            user = User.find_by(email: params[:email].downcase)
            unless user && user.authenticate(params[:password])
                render json: { error: 'Invalid email or password' }, status: :unauthorized
                return
            end
        end
  
        if user
            if user.activated?
                token = User.generate_jwt(user.id)
                render json: { jwt: token, user: { email: user.email, guest: user.email.include?('@example.com') } }, status: :created
            else
                render json: { error: 'Account not activated. Please check your email.' }, status: :forbidden
            end
        else
            render json: { error: 'Authentication failed.' }, status: :unauthorized
        end
    end

    private
  
    def create_guest_user
        id = User.maximum(:id).to_s
        user = User.new(
            name: 'Guest User ' + id,
            username: '@guest_user' + id,
            email: 'user' + id + '@example.com',
            password: 'aaaaaaaa', password_confirmation: 'aaaaaaaa',
            zip: '0000000', prefecture: '東京都', city: '〇〇区', street: '〇〇町',
            tel: '0000000000', profile: 'ゲストでお試しログインしています。ログアウトするとアカウントが破棄されます。',
            activated: true
        )
    
        if user.save
            Cart.create(user_id: user.id)
            StudyRecord.create(user_id: user.id)
            Lifecost.create(user_id: user.id)
            user.update(address: user.prefecture + user.city + user.street)
            user
        end
    end
end
  