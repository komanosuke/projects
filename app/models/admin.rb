class Admin < ApplicationRecord
    has_secure_password
    validates :name, presence: true

    def self.generate_jwt(admin_id)
        payload = { admin_id: admin_id, exp: 24.hours.from_now.to_i }
        JWT.encode(payload, Rails.application.credentials.secret_key_base, 'HS256')
    end
end
