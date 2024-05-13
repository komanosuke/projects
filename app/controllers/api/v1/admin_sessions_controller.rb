class Api::V1::AdminSessionsController < ApplicationController
  skip_before_action :authenticate_request, only: [:create]

  def create
    admin = Admin.find_by(name: params[:name])
    if admin && admin.authenticate(params[:password])
      token = Admin.generate_jwt(admin.id)
      render json: { jwt: token, admin: { name: admin.name } }, status: :created
    else
      render json: { error: 'Authentication failed.' }, status: :unauthorized
    end
  end
end
