module Api
  class UsersController < BaseController
    include Authenticatable

    skip_before_action :authenticate, only: [:create]

    # POST /api/users
    def create
      user = User.new(user_params)

      if user.save
        set_credential_headers(user.authorize!)
        render json: UserSerializer.new(user), status: :created
      else
        render json: { errors: user.errors }, status: :unprocessable_entity
      end
    end

    private

    def user_params
      params.require(:user).permit(:nickname, :password, :password_confirmation)
    end
  end
end
