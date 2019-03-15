module Api
  class BaseController < ApplicationController
    before_action :authenticate

    def authenticate
      user = User.find_by(nickname: request.headers['uid'])

      if user && user.authorized?(request.headers['client'], request.headers['access-token'])
        @curreent_user = user
      else
        render json: { error: 'Unauthorized' }, status: 401
      end
    end
  end
end
