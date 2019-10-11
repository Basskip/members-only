class User < ApplicationRecord
    attr_accessor :remember_token
    before_create :create_remember_token
    has_secure_password

    private

    def create_remember_token
        self.remember_token = SecureRandom.urlsafe_base64
        self.remember_digest = Digest::SHA1.hexdigest(remember_token.to_s)
    end
end
