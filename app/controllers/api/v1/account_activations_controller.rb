class Api::V1::AccountActivationsController < ApplicationController
    def edit
        user = User.find_by(email: params[:email])
        if user && !user.activated? && user.authenticated?(:activation, params[:id])
        user.activate
            render json: { message: "アカウントが有効化されました" }, status: :ok
        else
            render json: { message: "この有効化リンクは無効です" }, status: :unprocessable_entity
        end
    end
end
