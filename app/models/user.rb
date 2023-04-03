class User < ApplicationRecord
    has_secure_password
    has_many :todos
    has_many :books
    has_many :orders, dependent: :destroy
    validates :email,{ 
        presence: true,
        uniqueness: true
    }

    def generate_reset_password_token
        self.reset_password_token = SecureRandom.urlsafe_base64
        self.reset_password_token_expires_at = 1.hour.from_now
      end
    
      def reset_password_token_valid?
        reset_password_token.present? && reset_password_token_expires_at.present? && reset_password_token_expires_at > Time.now
      end
end
