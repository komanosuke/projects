class ApplicationController < ActionController::API
    before_action :authenticate_request
  
    private
  
    def authenticate_request
        header = request.headers['Authorization']
        return unless header
        
        header = header.split(' ').last if header
        begin
            @decoded = decode_token(header)
            if @decoded.nil?
                render json: { errors: 'Invalid token' }, status: :unauthorized
                return
            end
            @current_user = User.find(@decoded[:user_id])
        rescue ActiveRecord::RecordNotFound => e
            render json: { errors: e.message }, status: :unauthorized
        rescue JWT::DecodeError => e
            render json: { errors: e.message }, status: :unauthorized
        end
    end
  
    def decode_token(token)
        begin
            body = JWT.decode(token, Rails.application.credentials.secret_key_base, true, { algorithm: 'HS256' })[0]
            HashWithIndifferentAccess.new(body)
        rescue JWT::ExpiredSignature, JWT::VerificationError => e
            Rails.logger.info "JWT Decode Error: #{e.message}"
            nil
        end
    end
end
  