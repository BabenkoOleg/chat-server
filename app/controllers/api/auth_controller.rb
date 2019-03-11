module Api
  class AuthController < BaseController
    include Authenticatable

    skip_before_action :authenticate, only: [:create]

    # POST /api/auth
    def create
      user = User.find_by(nickname: auth_params[:nickname])

      if user.present? && user.authenticate(auth_params[:password])
        render_user_credentials(user)
      else
        render json: { error: 'Invalid nickname or password' }, status: 422
      end
    end

    def auth_params
      params.require(:auth).permit(:nickname, :password)
    end
  end
end
