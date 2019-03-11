module Api
  class BaseController < ApplicationController
    before_action :authenticate

    def authenticate
      bearer_token = extract_bearer_token

      if bearer_token
        decoded = ChatServer::Auth.decode(bearer_token)
        @current_user = decoded['user']
      else
        render json: { error: 'Bearer token not provided' }, status: 401
      end

    rescue JWT::ExpiredSignature
      render json: { error: 'Bearer token is expired' }, status: 401

    rescue JWT::DecodeError
      render json: { error: 'Bearer token is invalid' }, status: 401
    end

    private

    def extract_bearer_token
      http_authorization = request.env['HTTP_AUTHORIZATION']
      http_authorization ? http_authorization.scan(/Bearer (.*)$/).flatten.last : nil
    end
  end
end
