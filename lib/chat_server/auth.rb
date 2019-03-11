require 'jwt'

module ChatServer
  class Auth
    ALGORITHM = 'HS256'

    class << self
      def issue(payload)
        payload[:exp] ||= Time.now.to_i + 3600
        JWT.encode(payload, auth_secret, ALGORITHM)
      end

      def decode(token)
        JWT.decode(token, auth_secret, true, { algorithm: ALGORITHM }).first
      end

      def auth_secret
        Rails.application.credentials[Rails.env.to_sym][:jwt_secret]
      end
    end
  end
end
